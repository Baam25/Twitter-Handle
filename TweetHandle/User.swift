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
    var id:String?
    var name:String?
    var screen_name:String?
    
    init(profile_image:ProfileImage,id:String,name:String,screen_name:String) {
        self.profile_image = profile_image
        self.id = id
        self.name = name
        self.screen_name = screen_name
    }
}
