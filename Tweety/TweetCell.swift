//
//  TweetCell.swift
//  Tweety
//
//  Created by DGh0st on 2/13/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            displayNameLabel.text = tweet.user!.name
            usernameLabel.text = "@\(tweet.user!.screenname)"
            tweetLabel.text = tweet.text
            
            let timeSinceNow = (-1) * Int(tweet.createdAt!.timeIntervalSinceNow)
            var timeString = ""
            
            if timeSinceNow <= 60 {
                timeString = "\(timeSinceNow)s"
            } else if timeSinceNow <= 3600 {
                timeString = "\(timeSinceNow / 60)m"
            } else if timeSinceNow <= 86400 {
                timeString = "\(timeSinceNow / 3600)h"
            } else if timeSinceNow <= 31536000 {
                timeString = "\(timeSinceNow / 86400)d"
            } else if timeSinceNow > 31536000 {
                timeString = "\(timeSinceNow / 31536000)y"
            }
            timeLabel.text = timeString
            
            updateRetweetAndFavorites()
            profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl)!)
            
            // Note to self: Next time use IBActions instad of UIImageView
            let retweetTap = UITapGestureRecognizer(target: self, action: Selector("retweetTapped"))
            retweetImageView.addGestureRecognizer(retweetTap)
            retweetImageView.userInteractionEnabled = true
            let favoriteTap = UITapGestureRecognizer(target: self, action: Selector("favoriteTapped"))
            favoriteImageView.addGestureRecognizer(favoriteTap)
            favoriteImageView.userInteractionEnabled = true
            let profileImageTap = UITapGestureRecognizer(target: self, action: Selector("profileImageTapped"))
            profileImageView.addGestureRecognizer(profileImageTap)
            profileImageView.userInteractionEnabled = true
        }
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
    
    func profileImageTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profilesPage = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as? ProfileViewController {
            profilesPage.user = tweet.user
            let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: (window?.frame.width)!, height: (window?.frame.height)! / 4))
            navBar.barStyle = UIBarStyle.Default
            navBar.sizeToFit()
            let title = UINavigationItem(title: "")
            let cancelButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Done, target: nil, action: Selector("dismissProfile"))
            title.rightBarButtonItem = cancelButton
            title.titleView = UIImageView(image: UIImage(named: "Twitter_logo.png"))
            navBar.setItems([title], animated: true)
            profilesPage.view.addSubview(navBar)
            if var topController = UIApplication.sharedApplication().keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                topController.presentViewController(profilesPage, animated: true, completion: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 7
        profileImageView.clipsToBounds = true
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        displayNameLabel.preferredMaxLayoutWidth = displayNameLabel.frame.size.width
        usernameLabel.preferredMaxLayoutWidth = usernameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
