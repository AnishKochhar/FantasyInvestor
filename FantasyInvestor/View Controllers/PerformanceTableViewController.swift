//
//  PerformanceTableViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 27/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

/*
 Manages the table view embedded in the dashboard.
 Very standard table view methods
 */

import UIKit

class PerformanceTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    let performance = ["All Time": 8.75, "Last month": -2.14]
    
    let green = UIColor(red: 69/256, green: 196/256, blue: 69/256, alpha: 1.0)
    let red = UIColor(red: 200/256, green: 15/256, blue: 50/256, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        table.layer.cornerRadius = 5.0
        table.rowHeight = 80
        
        table.separatorColor = UIColor(red: 141/256, green: 141/256, blue: 141/256, alpha: 0.4)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Performance Cell
        let index = indexPath.row
        guard let cell = self.table.dequeueReusableCell(withIdentifier: "PerformanceCell") as? PerformanceCell else { return UITableViewCell()
        }
        if index == 0 {
            let timeFrame = "All Time"
            guard let profit = performance[timeFrame] else { return UITableViewCell() }
            cell.timeFrameLabel.text = timeFrame
            if profit >= 0.0 {
                cell.profitLabel.text = "+\(profit)%"
                cell.profitLabel.textColor = green
            } else {
                cell.profitLabel.text = "\(profit)%"
                cell.profitLabel.textColor = red
            }
        } else {
            let timeFrame = "Last month"
            guard let profit = performance[timeFrame] else { return UITableViewCell() }
            cell.timeFrameLabel.text = timeFrame
            if profit >= 0.0 {
                cell.profitLabel.text = "+\(profit)%"
                cell.profitLabel.textColor = green
            } else {
                cell.profitLabel.text = "\(profit)%"
                cell.profitLabel.textColor = red
            }
        }
        return cell

    }
}
