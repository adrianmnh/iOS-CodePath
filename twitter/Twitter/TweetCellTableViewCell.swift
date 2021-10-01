//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by MacBook Pro on 9/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var tweetContent: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var favButton: UIButton!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var replyButton: UIButton!
    

    
    var favorited:Bool = false
    var tweetId:Int = -1
    //var retweeted:Bool = false
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favorite(_ sender: Any) {
        
        let tobeFavorited = !favorited
        if (tobeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId,
                                                   success: { self.setFavorite(true) },
                                                   failure: { (error) in print("Favorite did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId,
                                                     success: { self.setFavorite(false) },
                                                     failure: { (error) in print("Unfavorite did not suceed: \(error)")
            })
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool ){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId,
                                         success: { self.setRetweeted(true) },
                                         failure: {(error) in print("Unable to retweet: \(error)")            
        })
    }
    
    @IBAction func reply(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
