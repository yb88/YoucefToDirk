//
//  User.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import Foundation
class User {
    fileprivate let streetkey = "street"
    fileprivate let suitekey = "suite"
    fileprivate let citykey = "city"
    fileprivate let zipcodekey = "zipcode"
    fileprivate let geokey = "geo"
    fileprivate let latkey = "lat"
    fileprivate let lngkey = "lng"
    fileprivate let addressKey = "address"
    fileprivate let usernameKey = "username"
    fileprivate let idkey = "id"
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var lat: String?
    var lng: String?

    
    var username: String
    var id: Int
    init(username: String, id: Int, suite: String, street: String, zipcode: String, lat: String, lng: String, city: String) {
        self.username = username
        self.id = id
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.lat = lat
        self.lng = lng
        self.street = street
        
    }
    init?(jsonDictionary: [String: AnyObject]) {
        guard let username = jsonDictionary[usernameKey] as? String else {return nil}
        guard let id = jsonDictionary[idkey] as? Int else {return nil}
        self.id = id
        self.username = username
        guard let addressDictionary = jsonDictionary[addressKey] as? [String: AnyObject] else {return}
        
        guard let street = addressDictionary[streetkey] as? String else {return nil}
        guard let suite = addressDictionary[suitekey] as? String else {return nil}
        guard let city = addressDictionary[citykey] as? String else {return nil}
        guard let zipcode = addressDictionary[zipcodekey] as? String else {return nil }
        guard let geo = addressDictionary[geokey] as? [String: AnyObject] else {return nil}
        guard let lat = geo[latkey] as? String else {return nil }
        guard let lng = geo[lngkey] as? String else {return nil}
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.lat = lat
        self.lng = lng

        
}
}
