//
//  Review.swift
//  E-shop
//
//  Created by Vyacheslav on 03.02.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import Foundation

struct Review: Codable {
    let id: Int
    let product: Int
    let rate: Int
    let text: String
    let created_by: ReviewOwner
    let created_at: String
}

struct ReviewOwner: Codable {
    let id: Int
    let username: String
    let first_name: String?
    let last_name: String?
    let email: String?
}
