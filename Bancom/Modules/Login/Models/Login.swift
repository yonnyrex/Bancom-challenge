//
//  Login.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import Foundation

struct Login: Codable {
    var success: Bool
    var accessToken: String
    var refreshToken: String
}
