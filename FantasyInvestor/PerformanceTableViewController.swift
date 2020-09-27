//
//  PerformanceTableViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 27/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class PerformanceTableViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    let performance = ["All Time": "+8.75%", "Last month": "-2.14%"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        table.rowHeight = 80
        table.layer.borderWidth = 2.0
        table.layer.borderColor = CGColor(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        table.layer.cornerRadius = 5.0
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
            cell.timeFrameLabel.text = timeFrame
            cell.profitLabel.text = performance[timeFrame]
        } else {
            let timeFrame = "Last month"
            cell.timeFrameLabel.text = timeFrame
            cell.profitLabel.text = performance[timeFrame]
        }
        return cell

    }
}
