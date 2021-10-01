//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by MacBook Pro on 9/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import AlamofireImage

import UIKit

class HomeTableViewController: UITableViewController {
    

    
    
    var numberOfTweets : Int!
//    var tweetArray = [[String:Any]]()
    // array of dictionaries
    var tweetArray = [NSDictionary]()
    
    let myRefreshControl = UIRefreshControl()
    
    
    
       
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)        
        tableView.refreshControl = myRefreshControl
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadTweets()
    }
    
    @objc func loadTweets(){
        
        numberOfTweets = 20
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        //let myParams = ["count":40]
        let myParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams,
        success: {(tweets: [NSDictionary]) in
            
            // clear array of tweets -> array of dictionaries
            self.tweetArray.removeAll()
            
            // all all tweets to array
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            // reload table view
            self.tableView.reloadData()
            
            // end refreshing
            self.myRefreshControl.endRefreshing()
        },
            failure: { Error in
            print("Could not...")
        })
        
        
    }
    
    func loadMoreTweets(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numberOfTweets = numberOfTweets + 20
        
        let myParams = ["count": numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams,
        success: {(tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        },
            failure: { Error in
            print("Could not...")
        })
        
    }


    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    
    
    
    // CellForRow
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Reuse cells loaded for memory optimization
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        // get DICTIONARY from current index row
        let user = (tweetArray[indexPath.row]["user"] as! [String:Any?]) //NSDictionary
        
        cell.userNameLabel.text = (user["name"] as! String)
        cell.tweetContent.text = (tweetArray[indexPath.row]["text"] as! String)
        
        let biggerImgUrl = (user["profile_image_url_https"] as! String).replacingOccurrences(of: "_normal", with: "")
     
      
        //set up image from dictionary.currentIndex
//        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)! )
        let imageUrl = URL(string: biggerImgUrl)
        
        // setting image using alamo fire library and image URL
        cell.profileImageView.af_setImage(withURL: imageUrl!)
        
        let timeString = (tweetArray[indexPath.row]["created_at"] as! String)
        
        cell.timeLabel.text = getRelativeTime(timeString: timeString)
        
        
//        let imageUrl = URL(string: (user["profile_image_url_https"] as! String) )
        
//        // setting a photo using Swift code and image URL
//        let data = try? Data(contentsOf: imageUrl!)
//
//        if let imageData = data {
//            cell.profileImageView.image = UIImage(data: imageData)
//        }
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = (tweetArray[indexPath.row]["id"] as! Int)
        
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        
        

        

        
        
        
        return cell
        
    }
        
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    func getRelativeTime(timeString: String) -> String{
        let time: Date
        let dateFormatter = DateFormatter()
        //"created_at": "Wed May 23 06:01:13 +0000 2007",
        dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        time = dateFormatter.date(from: timeString)!
        return time.timeAgoDisplay()
    }
}
// similar to java extends
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day

        if secondsAgo < minute {
            if secondsAgo == 1 || secondsAgo == 0 {
                return "\(secondsAgo) sec ago"}
            return "\(secondsAgo) secs ago"

        } else if secondsAgo < hour {
            if secondsAgo <= 60 {return "1 min ago"}
            return "\(secondsAgo / minute) mins ago"
            
        } else if secondsAgo < day {
            if secondsAgo <= 3600 {
                return "1 hr ago"}
            return "\(secondsAgo / hour) hrs ago"
            
        } else if secondsAgo < week {
            if secondsAgo < 3600*24*2 {
                return "1 day ago"}
            return "\(secondsAgo / day) days ago"
        }
        if secondsAgo < 3600*24*7*2 {
            return "1 week ago"}
        return "\(secondsAgo / week) weeks ago"
    }
}
