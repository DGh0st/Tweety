//
//  Tweet.swift
//  Tweety
//
//  Created by DGh0st on 2/13/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User!
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweets: Int?
    var favorites: Int?
    var id: String
    var favorited: Bool
    var retweeted: Bool
    
    init(dictionary: NSDictionary) {
        id = String(dictionary["id"]!)
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        // Note: formatters are expensive so having a static one would be better performace
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        retweets = dictionary["retweet_count"] as? Int
        favorites = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as! Bool
        retweeted = dictionary["retweeted"] as! Bool
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
