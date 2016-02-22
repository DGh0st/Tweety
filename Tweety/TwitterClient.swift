//
//  TwitterClient.swift
//  Tweety
//
//  Created by DGh0st on 2/9/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit
import BDBOAuth1Manager 

let twitterConsumerKey = "LxBt3WRH7QDTyU8ben5u54Ziw"
let twitterConsumerSecret = "RZQZ6uf9iXEMSyt8GCkgWNPRxNzWYs0AlyhqJ2KoYcceHou0e2"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {

    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in                
                print("Failed to get home timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "dgh0st://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                    let user = User(dictionary: response as! NSDictionary)
                    User.currentUser = user
                    print("User: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to get user")
                (self.loginCompletion?(user: nil, error: error))!
            })
        }, failure: { (error: NSError!) -> Void in
                print("Failed to recieve access token")
                self.loginCompletion?(user: nil, error: error)
        })
    }
    
    func retweetWithCompletion(id: Int, isRetweet: Bool, params: NSDictionary?, completion: (error: NSError?) -> ()) {
        var retweetOrUnretweet = "retweet"
        if (!isRetweet) {
            retweetOrUnretweet = "unretweet"
        }
        POST("1.1/statuses/\(retweetOrUnretweet)/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                completion(error:nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to \(retweetOrUnretweet)")
                completion(error: nil)
        })
    }
    
    func favoritewithCompletion(id: Int, isFavorite: Bool, params: NSDictionary?, completion: (error: NSError?) -> ()) {
        var createOrDestroy = "create"
        if (!isFavorite) {
            createOrDestroy = "destroy"
        }
        POST("1.1/favorites/\(createOrDestroy).json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                completion(error:nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to \(createOrDestroy) favorite")
                completion(error: error)
        })
    }
    
    func tweetWithCompletion(status: String, params: NSDictionary?, completion: (error: NSError?) -> ()) {
        POST("1.1/statuses/update.json?status=\(status)", parameters: params, success:  { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                completion(error:nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to tweet")
                completion(error: error)
        })
    }
}
