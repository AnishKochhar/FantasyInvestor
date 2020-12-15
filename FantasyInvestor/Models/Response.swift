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
    let timeSeriesDaily: [String: TimeSeries]
    
    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}

struct ResponseWeekly: Codable {
    let symbol: String
    let timeSeriesWeekly: [String: TimeSeries]
    
    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case timeSeriesWeekly = "Weekly Time Series"
    }
}

struct Response5min: Codable {
    let symbol: String
    let timeSeries5min: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case timeSeries5min = "Time Series (5min)"
    }
}
struct Response30min: Codable {
    let symbol: String
    let timeSeries30min: [String: TimeSeries]

    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case timeSeries30min = "Time Series (30min)"
    }
}

