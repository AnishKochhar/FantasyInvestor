//
//  Stock.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 13/10/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class Stock {
    var symbol: String
    var name: String
    var description: String
    var currentPrice: Double
    var yearFounded: Int
    var marketCap: String
    var logo: UIImage?
    
    init(symbol: String, name: String, description: String, currentPrice: Double, yearFounded: Int, marketCap: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.currentPrice = currentPrice
        self.yearFounded = yearFounded
        self.marketCap = marketCap
    }
}


