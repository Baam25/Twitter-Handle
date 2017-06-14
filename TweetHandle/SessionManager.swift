//
//  SessionManager.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 14/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import UIKit
import TwitterKit

class SessionManager {
    
    static var shared = SessionManager()
    
    var tweets = [Tweet]()
    var max_id:String?
    
    func parseNext_Results(next:String? = ""){
        let params = next?.components(separatedBy: "&")
        for p in params ?? [] {
            if p.contains("?max_id=") {
                max_id = p.components(separatedBy: "=")[1]
                return
            }
            continue
        }
        max_id = nil
    }
}
