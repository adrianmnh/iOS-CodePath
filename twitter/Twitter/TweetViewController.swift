//
//  TweetViewController.swift
//  Twitter
//
//  Created by MacBook Pro on 9/28/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var tweetTextView: UITextView!
    
    @IBOutlet var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countLabel.text = "140 characters left"
        tweetTextView.becomeFirstResponder()
        
        tweetTextView.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
       // TODO: Check the proposed new text character count
       // Allow or disallow the new text
        
        
        
        let count = textView.text.count
        let characterLimit = 140
        
        print("\(textView.text) - \(count)")

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        textCounter(newText)
        
        

        // TODO: Update Character Count Label

        // The new text should be allowed? True/False
        
        print(tweetTextView.text)

        return newText.count <= characterLimit
    }
    
    
    @IBAction func textCounter(_ textVar:String) {
        let count = textVar.count
        
        if count > 140{
            countLabel.text = "Tweet limit exceeded"
        } else {
            countLabel.text = "\(140 - count) characters left"
        }

    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
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
