//
//  User.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import UIKit

class User: NSObject {

    var profile_image:ProfileImage?
    var _id:String?
    var _name:String?
    var _screen_name:String?
    
    init(profile_image:ProfileImage,id:String,name:String,screen_name:String) {
        self.profile_image = profile_image
        self._id = id
        self._name = name
        self._screen_name = screen_name
    }
    
    var id:String {
        get{
            return _id ?? "1"
        }
    }
    
    var name:String{
        get{
            return _name ?? "Luke Skywalker"
        }
    }
    
    var screen_name:String{
        get{
            return _screen_name ?? "Jedi"
        }
    }
}

