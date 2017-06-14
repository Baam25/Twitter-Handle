//
//  APIManager.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//
import UIKit
import TwitterKit
import SwiftyJSON

class APIManager {
 
    class func loadData(handle:String = "@FlohNetwork", completionHandle:@escaping (Error?)->Void){
        let params = ["q":handle,
                      "result_type":"recent",
                      "count":"6"
        ]
        TwitterClient.shared.callTwitterSearchApi(params: params) { (tweets, error) in
            loadTweets(Tweets: tweets!)
            completionHandle(error)
        }
    }
    
    class func loadNextData(handle:String = "@FlohNetwork", completionHandle:@escaping (Error?)->Void){
        let params = ["q":handle,
                      "result_type":"recent",
                      "count":"6",
                      "max_id":SessionManager.shared.max_id ?? ""
        ]
        TwitterClient.shared.callTwitterSearchApi(params: params) { (tweets, error) in
            if SessionManager.shared.max_id != nil {
                loadTweets(Tweets: tweets!)
            }
            completionHandle(error)
        }
    }
    
    
    static internal func loadTweets(Tweets:JSON){
        var tweets = [Tweet]()
        
        SessionManager.shared.parseNext_Results(next: Tweets.dictionaryValue["search_metadata"]?.dictionaryValue["next_results"]?.stringValue)
        
        for tweet in Tweets.dictionaryValue["statuses"]!.arrayValue {
            
            let tTweet = tweet.dictionaryValue
            let tUser = tTweet["user"]?.dictionaryValue
            let tProfileImage = tUser?["profile_image_url_https"]?.stringValue
            
            let profile_image = ProfileImage(url: URL(string: tProfileImage!)!)
            
            let user = User(profile_image: profile_image, id: tUser!["id"]!.stringValue, name: tUser!["name"]!.stringValue, screen_name: tUser!["screen_name"]!.stringValue)
            
            let tweet = Tweet(text: tTweet["text"]!.stringValue, created_at: tTweet["created_at"]!.stringValue, user: user)
            
            tweets.append(tweet)
        }
        SessionManager.shared.tweets.append(contentsOf: tweets)
    }
}
