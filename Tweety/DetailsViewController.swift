//
//  DetailsViewController.swift
//  Tweety
//
//  Created by DGh0st on 2/18/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        displayNameLabel.text = tweet!.user!.name
        userNameLabel.text = "@\(tweet!.user!.screenname)"
        tweetTextLabel.text = tweet!.text
        dateLabel.text = tweet!.createdAtString
        updateRetweetAndFavorites()
        profileImageView.setImageWithURL(NSURL(string: tweet!.user!.profileImageUrl)!)
        profileImageView.layer.cornerRadius = 9
        profileImageView.clipsToBounds = true
        
        // Note to self: Next time use IBActions instad of UIImageView
        let retweetTap = UITapGestureRecognizer(target: self, action: Selector("retweetTapped"))
        retweetImageView.addGestureRecognizer(retweetTap)
        retweetImageView.userInteractionEnabled = true
        let favoriteTap = UITapGestureRecognizer(target: self, action: Selector("favoriteTapped"))
        favoriteImageView.addGestureRecognizer(favoriteTap)
        favoriteImageView.userInteractionEnabled = true
    }
    
    func updateRetweetAndFavorites() {
        // update retweet
        if tweet.retweeted == true {
            self.retweetImageView.image = UIImage(named: "retweet-action-on.png")
        } else {
            self.retweetImageView.image = UIImage(named: "retweet-action.png")
        }
        self.retweetCountLabel.text = String(tweet.retweets!)
        if tweet.retweets! > 0 {
            self.retweetCountLabel.hidden = false
        } else {
            self.retweetCountLabel.hidden = true
        }
        
        // update favorites
        if tweet.favorited == true {
            self.favoriteImageView.image = UIImage(named: "like-action-on.png")
        } else {
            self.favoriteImageView.image = UIImage(named: "like-action.png")
        }
        self.favoriteCountLabel.text = String(tweet.favorites!)
        if tweet.favorites! > 0 {
            self.favoriteCountLabel.hidden = false
        } else {
            self.favoriteCountLabel.hidden = true
        }
    }
    
    func retweetTapped() {
        tweet.retweeted = !tweet.retweeted
        if tweet.retweeted {
            tweet.retweets! += 1
        } else {
            tweet.retweets! -= 1
        }
        TwitterClient.sharedInstance.retweetWithCompletion(Int(tweet.id)!, isRetweet: tweet.retweeted, params: nil, completion: { (error) -> () in
            if error != nil {
                print("Retweet failed")
            }
        })
        
        updateRetweetAndFavorites()
    }
    
    func favoriteTapped() {
        tweet.favorited = !tweet.favorited
        if tweet.favorited {
            tweet.favorites! += 1
        } else {
            tweet.favorites! -= 1
        }
        
        TwitterClient.sharedInstance.favoritewithCompletion(Int(tweet.id)!, isFavorite: tweet.favorited, params: nil, completion: { (error) -> () in
            if error != nil {
                print("Favorite failed")
            }
        })
        
        updateRetweetAndFavorites()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
