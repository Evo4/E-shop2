//
//  User.swift
//  E-shop
//
//  Created by Vyacheslav on 31.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let password: String
    let token: String
}

struct SignInUser: Codable {
    let photo: Data?
    let name: String
    let surname: String
}
