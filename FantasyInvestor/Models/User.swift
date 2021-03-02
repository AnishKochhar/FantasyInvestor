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
    var profit: Double
    
    internal init(id: String, username: String, profit: Double) {
        self.id = id
        self.username = username
        self.profit = profit
    }
    
    func setProfit(_ profit: Double) {
        self.profit = profit
    }
}

