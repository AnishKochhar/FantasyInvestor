//
//  DashboardTableCells.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 22/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class PerformanceCell: UITableViewCell {
    @IBOutlet weak var timeFrameLabel: UILabel!
    @IBOutlet weak var profitLabel: UILabel!
}

class InstrumentsCell: UITableViewCell {
    @IBOutlet weak var instrumentLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var profitPercentageLabel: UILabel!
}


