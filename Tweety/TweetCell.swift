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
            usernameLabel.text = "@\(tweet.user!.screenname!)"
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
            
            retweetCountLabel.text = String(tweet.retweets!)
            favoriteCountLabel.text = String(tweet.favorites!)
            if tweet.retweets == 0 {
                retweetCountLabel.hidden = true
            } else {
                retweetCountLabel.hidden = false
            }
            if tweet.favorites == 0 {
                favoriteCountLabel.hidden = true
            } else {
                favoriteCountLabel.hidden = false
            }
            profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            
            // Note to self: Next time use IBActions instad of UIImageView
            let retweetTap = UITapGestureRecognizer(target: self, action: Selector("retweetTapped"))
            retweetImageView.addGestureRecognizer(retweetTap)
            retweetImageView.userInteractionEnabled = true
            let favoriteTap = UITapGestureRecognizer(target: self, action: Selector("favoriteTapped"))
            favoriteImageView.addGestureRecognizer(favoriteTap)
            favoriteImageView.userInteractionEnabled = true
        }
    }
    
    func retweetTapped() {
        if self.retweetImageView.image != UIImage(named: "retweet-action-on.png") {
            self.retweetImageView.image = UIImage(named: "retweet-action-on.png")
            self.retweetCountLabel.text = String(tweet.retweets! + 1)
        
            if tweet.retweets! + 1 > 0 {
                self.retweetCountLabel.hidden = false
            } else {
                self.retweetCountLabel.hidden = true
            }
        } else {
            self.retweetImageView.image = UIImage(named: "retweet-action.png")
            self.retweetCountLabel.text = String(tweet.retweets!)
            
            if tweet.retweets! > 0 {
                self.retweetCountLabel.hidden = false
            } else {
                self.retweetCountLabel.hidden = true
            }
        }
    }
    
    func favoriteTapped() {
        if self.favoriteImageView.image != UIImage(named: "like-action-on.png") {
            self.favoriteImageView.image = UIImage(named: "like-action-on.png")
            self.favoriteCountLabel.text = String(tweet.favorites! + 1)
        
            if tweet.favorites! + 1 > 0 {
                self.favoriteCountLabel.hidden = false
            } else {
                self.favoriteCountLabel.hidden = true
            }
        } else {
            self.favoriteImageView.image = UIImage(named: "like-action.png")
            self.favoriteCountLabel.text = String(tweet.favorites!)
            
            if tweet.favorites! > 0 {
                self.favoriteCountLabel.hidden = false
            } else {
                self.favoriteCountLabel.hidden = true
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
