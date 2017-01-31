//
//  User.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import Foundation
class User {
    fileprivate let usernameKey = "username"
    fileprivate let array = "array"
//    fileprivate let userIDKey = "userId"
    
    var username: String
//    var userID: Int
    init(username: String) {
        self.username = username
//        self.userID = userID
    }
    init?(jsonDictionary: [String: AnyObject]) {
        guard let username = jsonDictionary[usernameKey] as? String else {return nil}
//        guard let userID = jsonDictionary[userIDKey] as? Int else {return nil}
//        self.userID = userID
        self.username = username
        
}
}
