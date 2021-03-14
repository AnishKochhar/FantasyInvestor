//
//  Stock.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 13/10/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

/*
 Stock: Contains an image and a symbol (for use in the collection view)
 StockInfo: Provides extra information about a stock, e.g., yearFounded (for use in the detail screen)
 */

import Foundation
import Parse

class StockInfo: Codable {
    var symbol: String
    var name: String
    var description: String
    var currentPrice: Double
    var yearFounded: Int
    var marketCap: String
    
    init(symbol: String, name: String, description: String, currentPrice: Double, yearFounded: Int, marketCap: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.currentPrice = currentPrice
        self.yearFounded = yearFounded
        self.marketCap = marketCap
    }
    
    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case name = "Name"
        case description = "Description"
        case currentPrice = "Current Price"
        case yearFounded = "Founded"
        case marketCap = "Market Cap"
    }
}

class Stock {
    var image: PFFileObject?
    var symbol: String
    
    init(symbol: String, image: PFFileObject) {
        self.image = image
        self.symbol = symbol
    }
    
    init(pfObject: PFObject) {
        self.image = pfObject["Image"] as? PFFileObject
        self.symbol = pfObject["Symbol"] as! String
    }
}

