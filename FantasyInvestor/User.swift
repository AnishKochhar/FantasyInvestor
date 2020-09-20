//
//  User.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 16/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation

class User {
    let id: String
    let username: String
    var password: String
    let email: String
    
    init(id: String, username: String, password: String, email: String) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
    }
}
