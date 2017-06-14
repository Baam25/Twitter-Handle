//
//  TwitterClient.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import TwitterKit
import SwiftyJSON

class TwitterClient:NSObject {
    
    let defaults = UserDefaults.standard
    var userSession:TWTRSession!
    var client:TWTRAPIClient!
    let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
    var clientError : NSError?
    
    static var shared = TwitterClient()
    
    override init() {
        super.init()
        let decoded = defaults.object(forKey: "log_in_session") as! Data
        let userSession = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! TWTRSession
        client = TWTRAPIClient(userID: userSession.userID)
    }
    func callTwitterSearchApi(params: [String:String], completionHandler:@escaping (JSON?,Error?) -> Void){
        
        
        let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
                completionHandler(nil, connectionError)
            }
            
            let json = JSON(data: data!)
            completionHandler(json,nil)
            
        }
        
    }
    
}
