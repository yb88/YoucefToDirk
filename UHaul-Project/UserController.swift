//
//  UserController.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import Foundation
class UserController {
    
    static let  baseURLString = "http://jsonplaceholder.typicode.com/users"
    static let baseUrl = NSURL(string: baseURLString)
    static func getUsers(completion: @escaping(_ users: [User]) -> Void) {
        NetworkController.dataAtURL(url: baseUrl!) { (data) in
            guard let data = data else {return}
            guard let json = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) else {
                print("Error Getting Data")
                completion([])
                return
            }
            if let usersArray = json as? [Any] {
                var users: [User] = []
                for userDictionary in usersArray {
                    if let newUser = User(jsonDictionary: userDictionary as! [String : AnyObject]) {
                        users.append(newUser)
                    }
                    
                    
                }
                completion(users)
            } else {
                completion([])
            }
            
        }
    }
    static func getPosts(_ userId: String,completion: @escaping(_ posts: [Post]) -> Void) {
        let url = NetworkController.searchByUserID(userId)
        NetworkController.dataAtURL(url: url as NSURL) { (data) in
            guard let data = data else {return}
            guard let json = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) else {
                completion([])
                return
            }
            if let array = json as? [Any] {
                var posts: [Post] = []
                for postDictionary in array {
                    if let post = Post(jsonDictionary: postDictionary as! [String : AnyObject]) {
                        posts.append(post)
                    }
                    
                    
                }
                completion(posts)
            }
            
        }
    }
}
