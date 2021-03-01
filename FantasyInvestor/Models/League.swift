//
//  League.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 15/12/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation

struct League {
    var name: String
    var users: [User]
    var position: Int?
    
    internal init(name: String, users: [User], position: Int?) {
        self.name = name
        self.users = users
        self.position = position
    }
    
    
}
