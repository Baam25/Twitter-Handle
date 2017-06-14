//
//  ProfileImage.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import UIKit

class ProfileImage: NSObject {

    var url:URL?
    var background_url:URL?
    
    init(url:URL,background_url:URL? = URL(string:"http://google.com")){
        self.url = url
        self.background_url = background_url
    }
}
