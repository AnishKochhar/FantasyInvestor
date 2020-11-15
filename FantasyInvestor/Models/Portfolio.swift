//
//  Portfolio.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 21/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation

struct Portfolio {
    var prices: [String: Double]
    private var symbols = [String]()
    var balance: Double = 0.0
    
    init(prices: [String: Double]) {
        self.prices = prices
    }
    
    mutating func addInstrument(symbol: String, price: Double) {
        prices.updateValue(price, forKey: symbol)
        symbols.append(symbol)
    }
    
    func getSymbol(index: Int) -> String {
        return self.symbols[index]
    }
    
    mutating func setBalance(balance: Double) {
        self.balance = balance
    }
}

var portfolio: Portfolio = Portfolio(prices: [String: Double]())
