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

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet var tableView: UITableView!

    var numberOfPosts:Int = 2
    
    var posts = [PFObject]()
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad")

        
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
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
        
        numberOfPosts = 4
        print("POSTS LOADED")
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
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
        query.includeKey("author")
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count {
            loadMorePosts()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let post = posts[indexPath.row]
//         reverse feed!
//        let number = posts.count - 1
//        let post = posts[number - indexPath.row]
        
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        print("*")
        
        cell.photoView.af.setImage(withURL: url)
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
