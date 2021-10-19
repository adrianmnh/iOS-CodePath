//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Oberon on 10/14/21.
//

import UIKit
import Parse
import AlamofireImage
import StoreKit
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
  

    @IBOutlet var tableView: UITableView!

    var numberOfPosts:Int = 2
    
    var posts = [PFObject]()
    
    let myRefreshControl = UIRefreshControl()
    
    let commentBar = MessageInputBar()
    
    var showsCommentBar:Bool = false
    
    var selectedPost: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad")
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        
        commentBar.sendButton.title = "Post"
        
        commentBar.delegate = self
        
        

        
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // create the comment
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!
        
        selectedPost.add(comment, forKey: "comments")
        
        selectedPost.saveInBackground{(success, error) in
            if success {
                print("Success comment saved")
            } else {
                print("Error no comment saved")
            }
        }
        
        //clear and dismiss input bar
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
        
        
    }
    
    @objc func keyboardWillBeHidden(note: Notification) {
        
        
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        //commentBar.inputTextView.resignFirstResponder()
        
    }
    
    override var inputAccessoryView: UIView?{
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool{
        //return true
        return showsCommentBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("ViewDidAppear")

        
        
        super.viewDidAppear(animated)
        
        loadPosts()
        
        print("LENGTH: \(posts.count)")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("DID Disapear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("WILL Dissapear")
    }
    
    override func viewWillAppear(_ animated: Bool){
        print("ViewWillLoad")

    }
    
    @objc func loadPosts(){
        
        numberOfPosts = 10
        print("POSTS LOADED")
        
        let query = PFQuery(className: "Posts")
        //query.includeKey("author")
        //query.includeKeys(["author", "comments"])
        query.includeKeys(["author", "comments", "comments.author"])

        
        
        // number of posts initially 5
        query.limit = numberOfPosts
        
        query.order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                print("LENGTH: \(posts?.count)")
                self.posts = posts!
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
        print("LENGTH1: \(posts.count)")
        print("POSTS END LOADING")
    }
    
    func loadMorePosts(){
        
        if posts.count >= numberOfPosts {
            
        print("MORE POSTS LOADED")
        
        let query = PFQuery(className: "Posts")
        //query.includeKey("author")
        //query.includeKeys(["author", "comments"])
            query.includeKeys(["author", "comments", "comments.author"])
        numberOfPosts += 2
        query.limit = numberOfPosts
            
        query.order(byDescending: "createdAt")
        
        //self.posts.removeAll()

            
            query.findObjectsInBackground { (posts, error) in
                if posts != nil {
                    print("LENGTH2: \(posts!.count)")
                    self.posts = posts!
                    self.tableView.reloadData()
                }
            }
            
        }


        
        print("MORE POSTS ENDED")
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        //return comments.count + 1
        return comments.count + 2 // adding comment cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //if indexPath.row + 1 == posts.count {
        if indexPath.section + 1 == posts.count {
            loadMorePosts()
        }
    }
    
    

    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //         reverse feed!
        //        let number = posts.count - 1
        //        let post = posts[number - indexPath.row]
        
        //let post = posts[indexPath.row] // changed to section
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        // What type of cell do i return?
        // the post cell is always the first row
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            let user = post["author"] as! PFUser
            cell.usernameLabel.text = user.username
            cell.captionLabel.text = post["caption"] as! String
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            print("*")
            
            cell.photoView.af.setImage(withURL: url)
            
            
            return cell
        //} else if indexPath.row <= comments.count { // shows comment cell
        } else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            let comment = comments[indexPath.row - 1]
            
            let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username

            

            cell.commentLabel.text = comment["text"] as! String
            
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            
            return cell
        }
        
        
        
        


    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let post = posts[indexPath.row]
        let post = posts[indexPath.section]
        
        //let comments = PFObject(className: "Comments")
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1 {
            showsCommentBar = true
            becomeFirstResponder()
        }
        
        selectedPost = post
        
        
        
        
//        comment["text"] = "This is a random comment"
//        comment["post"] = post
//        comment["author"] = PFUser.current()!
//
//        post.add(comment, forKey: "comments")
//
//        post.saveInBackground{(success, error) in
//            if success {
//                print("Comment saved")
//            } else {
//                print("Error saving comment")
//            }
//        }
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        //let delegate = UIApplication.shared.delegate as! SceneDelegate
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        delegate.window?.rootViewController = loginViewController
    }
}
