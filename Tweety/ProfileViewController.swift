//
//  ProfileViewController.swift
//  Tweety
//
//  Created by DGh0st on 2/19/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after view appears
        if user == nil {
            user = _currentUser
        }
        let _bannerImage = user.dictionary["profile_banner_url"] as! String
        bannerImageView.setImageWithURL(NSURL(string: _bannerImage)!)
        bannerImageView.layer.zPosition -= 10
        profileImageView.setImageWithURL(NSURL(string: user.profileImageUrl)!)
        profileImageView.layer.cornerRadius = 9
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.blackColor().CGColor
        nameLabel.text = user.name
        screenNameLabel.text = "@\(user.screenname)"
        descriptionLabel.text = user.tagline
        tweetCountLabel.text = "\(user.dictionary["statuses_count"]!) tweets"
        followingCountLabel.text = "\(user.dictionary["friends_count"]!) following"
        followersCountLabel.text = "\(user.dictionary["followers_count"]!) followers"
    }
    
    func dismissProfile() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
