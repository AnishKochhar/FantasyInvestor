//
//  Response.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 14/12/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation


struct ResponseDaily: Codable {
    
    let symbol: String
    let timeSeriesDaily: [String: TimeSeriesDaily]
    
    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}

