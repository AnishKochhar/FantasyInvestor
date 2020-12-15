//
//  TimeSeries.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 12/12/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation

protocol TimeSeriesProtocol: Codable {
    var close: String { get }
}

struct TimeSeries: TimeSeriesProtocol, Codable {
    var close: String
    
    enum CodingKeys: String, CodingKey {
        case close = "4. close"
    }
}



