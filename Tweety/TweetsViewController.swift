//
//  TweetsViewController.swift
//  Tweety
//
//  Created by DGh0st on 2/13/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Twitter_logo.png"))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "didRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        didRefresh(refreshControl)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log off?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Logout", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
            User.currentUser?.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func didRefresh(refreshControl: UIRefreshControl) {
        requestTweets()
        refreshControl.endRefreshing()
    }
    
    func requestTweets() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            if error == nil {
                self.tweets = tweets
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Network Error", message: "There was an error while getting the home timeline", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
                    self.requestTweets()
                }))
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailsSegue" {
            let _detailsViewController = segue.destinationViewController as! DetailsViewController
            let index = tableView.indexPathForCell(sender as! UITableViewCell)!.row
            _detailsViewController.tweet = tweets![index]
        }
    }
    
}
