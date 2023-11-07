//
//  Post.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}
