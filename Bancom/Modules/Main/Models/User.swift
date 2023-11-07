//
//  User.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import Foundation

struct User: Codable, Identifiable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company

}

struct Address: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
}

struct Geo: Codable {
    var lat: String
    var lng: String
}

struct Company: Codable {
    var name: String
    var catchPhrase: String
    var bs: String
}
