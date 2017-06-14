//
//  Tweet.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text:String?
    var created_at:Date?
    var user:User?
    
    
    init(text:String,created_at:Date,user:User) {
        super.init()
        self.text = text
        self.created_at = created_at
        self.user = user
        
    }
    
    
}
