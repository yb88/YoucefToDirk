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
    static func getPosts(_ userId: Int,completion: @escaping(_ posts: [Post]) -> Void) {
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
    
    // create new post
    
    static func postRequest() {
        let enpointURL = URL(string:"http://jsonplaceholder.typicode.com/posts")
        var url = URLRequest(url: enpointURL!)
        url.httpMethod = "POST"
        let newPost : [String: AnyObject] = [
            "userId" : 1 as AnyObject,
            "title" : " beach" as AnyObject,
            "body" : "ocean is good" as AnyObject
        ]
        do {
            let posted = try JSONSerialization.data(withJSONObject: newPost, options: [])
            url.httpBody = posted
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else {
                    print("Error Data")
                    return
                }
                guard error == nil else {
                    return
                }
                
            })
            
            
        } catch {
            print(error.localizedDescription)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("error converting the json object into model data")
                return
            }
            // send json result
            do {
                guard let newData = try JSONSerialization.data(withJSONObject: data, options: []) as? [String: Any] else {
                    print("problem getting json data as a dictionary we can use")
                    return
                }
                guard let userID = newData["id"] as? Int else {
                    print("problem getting the userID")
                }
                print("successfully getting id: \(userID)")
            } catch {
                print(error.localizedDescription)
                
            }
            
            
        }
        task.resume()
        
    }
    
    // delete request
    static func delete() {
    let url = URL(string: UserController.endpoint)
    var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                print("error in delete")
                return
            }
            print("successfully deleted")
        }
        task.resume()
    
    
    }
}
