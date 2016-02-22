//
//  ComposeViewController.swift
//  Tweety
//
//  Created by DGh0st on 2/21/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var characterCountItem: UIBarButtonItem!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    var tweetString: String = ""
    var characterCountLeft: Int = 140
    var responseTo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tweetText.delegate = self
        
        characterCountItem.title = String(140)
        if responseTo != nil {
            tweetText.text = responseTo
            tweetString = responseTo!
            characterCountLeft = 140 - responseTo!.characters.count
        } else {
            tweetText.text = ""
        }
        profileImageView.setImageWithURL(NSURL(string: (_currentUser?.profileImageUrl)! as String)!)
        nameLabel.text = _currentUser?.name
        screenNameLabel.text = "@\((_currentUser?.screenname)!)"
        
        tweetText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.text.characters.count <= 140 {
            tweetString = textView.text
        }
        characterCountLeft = 140 - textView.text.characters.count
        characterCountItem.title = String(characterCountLeft)
    }

    @IBAction func onTweetTap(sender: AnyObject) {
        if characterCountLeft >= 0 && characterCountLeft < 140 {
            TwitterClient.sharedInstance.tweetWithCompletion(tweetString, params: nil, completion: { (error) -> () in
                if error != nil {
                    print("Failed to send tweet")
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let tweetsPage = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as? TweetsViewController {
                    tweetsPage.requestTweets()
                }
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
