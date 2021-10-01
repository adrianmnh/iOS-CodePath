//
//  TweetViewController.swift
//  Twitter
//
//  Created by MacBook Pro on 9/28/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet var tweetTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextField.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextField.text, success: {
                self.dismiss(animated: true)
            }, failure: { (error) in
                print("Error posting tweet. \(error)")
                self.dismiss(animated: true)
            })
        } else {
            self.dismiss(animated: true)
        }
        
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
