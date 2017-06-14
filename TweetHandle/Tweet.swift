//
//  Tweet.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var _text:String?
    var _created_at:Date?
    var user:User?
    
    
    init(text:String,created_at:String,user:User) {
        super.init()
        self._text = text
        self.created_at = created_at
        self.user = user
        
    }
    
    var text: String{
        get{
            return _text ?? "The Last Jedi"
        }
    }
    
    var created_at:String{
        get{
            return _created_at?.DatetoString() ?? ""
        }
        set{
            _created_at = created_at.StringtoDate()
        }
    }
}
