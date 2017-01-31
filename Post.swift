//
//  Post.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import Foundation
class Post {
    fileprivate let titleKey = "title"
    fileprivate let bodyKey = "body"
    fileprivate let userIDKey = "userId"
    fileprivate let idKey = "id"
    var title: String?
    var body: String?
    var userID: Int?
    var id: Int?
    init?(jsonDictionary: [String: AnyObject]) {
        guard let title = jsonDictionary[titleKey] as? String else {return nil}
        guard let body = jsonDictionary[bodyKey] as? String else { return nil}
        guard let userID = jsonDictionary[userIDKey] as? Int else {return nil}
        guard let id = jsonDictionary[idKey] as? Int else {return nil}
        
        self.title = title
        self.body = body
        self.userID = userID
        self.id = id
    }
}
