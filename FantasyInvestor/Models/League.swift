//
//  League.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 15/12/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation

struct League {
    let name: String
    let position: Int
    
    init(name: String, position: Int) {
        self.name = name
        self.position = position
    }
}
