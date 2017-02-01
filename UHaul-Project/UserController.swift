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
    // PUT request
    func putRequest() {
        let url = URL(string: "http://jsonplaceholder.typicode.com/posts/1")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body: [String : Any] = [
            "id" : 1,
            "userId" : 1,
            "title" : "put title",
            "body" : "put detail body"
        ]
        do {
            let data = try JSONSerialization.data(withJSONObject: body, options: [])
            
            request.httpBody = data
        }
        catch {
            print(error.localizedDescription)
        }
        let session = URLSession(configuration: .default)
        session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("\(error)")
            }
            if data != nil {
                print(data!)
                
                do {
                    let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    
                    if let jsonData = jsonDictionary {
                        print(jsonData)
                    }
                }
                catch {
                }
            }
            
        }) .resume()
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
