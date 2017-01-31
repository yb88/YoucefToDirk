//
//  Address.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import Foundation
class Address {
    fileprivate let streetkey = "street"
    fileprivate let suitekey = "suite"
    fileprivate let citykey = "city"
    fileprivate let zipcodekey = "zipcode"
    fileprivate let geokey = "geo"
    fileprivate let latkey = "lat"
    fileprivate let lngkey = "lng"
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var lat: Double?
    var lng: Double?
    var geo: [String: AnyObject]?

    init?(jsonDictionary: [String: AnyObject]) {
        guard let street = jsonDictionary[streetkey] as? String else {return}
        guard let suite = jsonDictionary[suitekey] as? String else {return}
        guard let city = jsonDictionary[citykey] as? String else {return}
        guard let zipcode = jsonDictionary[zipcodekey] as? String else {return}
        guard let geo = jsonDictionary[geokey] as? [String: AnyObject] else {return}
        guard let lat = geo[latkey] as? Double else {return }
        guard let lng = geo[lngkey] as? Double else {return}
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
        self.lat = lat
        self.lng = lng
}
}
