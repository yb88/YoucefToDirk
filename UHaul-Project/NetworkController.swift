//
//  NetworkController.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import Foundation

class NetworkController {
    static let baseURLString = "http://jsonplaceholder.typicode.com/posts?userId="
    static func searchByUserID(_ userId: String) -> URL {
        return URL(string: NetworkController.baseURLString + "\(userId)")!
    }

    
    static func dataAtURL(url: NSURL, completion: @escaping(_ data: NSData?) -> Void) {
        // Creates data task and returns the data at the url path
        let dataTask = URLSession.shared.dataTask(with: url as URL) { (data, _, error) -> Void in
            if error != nil {
                print("Error getting data")
                print(error!)
                completion(nil)
            } else {
                completion(data as NSData?)
            }
        }
        dataTask.resume()
    }
}
