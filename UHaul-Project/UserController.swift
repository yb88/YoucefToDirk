//
//  UserController.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import Foundation
class UserController {
    static let endpoint = "http://jsonplaceholder.typicode.com/posts/"
    
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
    static func getPosts(_ completion: @escaping(_ posts: [Post]) -> Void) {
        let url = NetworkController.searchByUserID()
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
    
    // POST create new post request
    
    static func postRequest() {
        let enpointURL = URL(string:"http://jsonplaceholder.typicode.com/posts")
        var url = URLRequest(url: enpointURL!)
        url.httpMethod = "POST"
        let newPost : [String: AnyObject] = [
            "userId" : 1 as AnyObject,
            "title" : " beach" as AnyObject,
            "body" : "ocean is good" as AnyObject
        ]
        let json: Data
        do {
            json = try JSONSerialization.data(withJSONObject: newPost, options: [])
            url.httpBody = json
        } catch {
            print("error setting json data")
            return
        }
        NetworkController.dataAtURLRequest(url: url) { (data) in
            guard let data = data else {
                return
            }
            print("successfully setting the data: \(newPost)")
        }
    }
    // PUT request
    static func putRequest() {
        let url = URL(string: "http://jsonplaceholder.typicode.com/posts/1")!
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = "PUT"
        requestUrl.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body: [String : Any] = [
            "id" : 1,
            "userId" : 1,
            "title" : "put title",
            "body" : "put detail body"
        ]
        do {
            let data = try JSONSerialization.data(withJSONObject: body, options: [])
            
            requestUrl.httpBody = data
        }
        catch {
            print(error.localizedDescription)
        }
        NetworkController.dataAtURLRequest(url: requestUrl) { (data) in
            guard let data = data else {
                return
            }
            print("successfully put data: \(data)")
            print(body)
        }
        
    }
    // delete request
    static func delete() {
        let url = URL(string: UserController.endpoint)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "DELETE"
        NetworkController.dataAtURLRequest(url: urlRequest) { (data) in
            guard let data = data else {
                return
            }
            print("successfully delete data: \(data)")
        }
    }
}
