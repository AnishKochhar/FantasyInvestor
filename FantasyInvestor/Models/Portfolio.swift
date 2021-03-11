//
//  Portfolio.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 21/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation
import Parse

struct Portfolio {
    var prices: [String: (Double, Double)]
    private var symbols = [String]()
    private var leagues = [String]()
    var balance: Double = 0.0
    private var id = String()
    
    init(prices: [String: (Double, Double)]) {
        self.prices = prices
    }
    
    mutating func addInstrument(symbol: String, price: Double, amount: Double) {
        prices.updateValue((price, amount), forKey: symbol)
        symbols.append(symbol)
    }
    
    mutating func buyInstrument(symbol: String, price: Double, amount: Double) {
        self.addInstrument(symbol: symbol, price: price, amount: amount)
        self.balance -= (price * amount)
        
        self.updatePortfolio()
    }
    
    mutating func sellInstrument(symbol: String, value: Double) {
        prices.removeValue(forKey: symbol)
        self.balance += (value)
        
        self.symbols = symbols.filter { $0 != symbol }
        
        self.updatePortfolio()
    }
    
    mutating func updateLeagues(leagues: [String]) {
        self.leagues = leagues
    }
    
    func getLeagues() -> [String] {
        return self.leagues
    }
    
    func getAmount(symbol: String) -> Double {
        if let stock = prices[symbol] {
            return stock.1
        }
        return 0
    }
    
    func getSymbol(index: Int) -> String {
        return self.symbols[index]
    }
    
    mutating func setBalance(balance: Double) {
        self.balance = balance
    }
    
    mutating func setId(id: String) {
        self.id = id
    }
    
    func getID() -> String {
        return self.id
    }
    
    func checkIfExists(target: String) -> Bool {
        for symbol in symbols {
            if (target == symbol) { return false }
        }
        return true
    }
    
    func updatePortfolio() {
        var pricesList = [Double]()
        var volumesList = [Double]()
        
        for (_, purchase) in self.prices {
            pricesList.append(purchase.0)
            volumesList.append(purchase.1)
        }
        
        let query = PFQuery(className: "Portfolio")
        query.whereKey("User", equalTo: id)
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) -> Void in
            if error != nil { print(error!) }
            else if let object = object {
                object["Instruments"] = self.symbols
                object["Balance"] = self.balance
                object["Prices"] = pricesList
                object["Volumes"] = volumesList
                object["Leagues"] = self.leagues
                
                object.saveInBackground()
            }
        }
    }
}

var portfolio: Portfolio = Portfolio(prices: [String: (Double, Double)]())
var textFileLoader = loadTextFile()
var currentStocks = [StockInfo]()

