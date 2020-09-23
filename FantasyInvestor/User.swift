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
    var portfolio: Portfolio
    
    
    init(id: String, username: String, portfolio: Portfolio) {
        self.id = id
        self.username = username
        self.portfolio = portfolio
    }
}

