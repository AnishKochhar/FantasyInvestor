//
//  DashboardViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 22/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let performance = ["All Time": "+8.75%", "One month": "-2.14%"]

    var portfolio: Portfolio = Portfolio(prices: [String: Double](), profit: 0.0)

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portfolio.addInstrument(symbol: "Amazon", price: 3077.96)
        portfolio.addInstrument(symbol: "Apple", price: 111.90)
        portfolio.addInstrument(symbol: "Tesla", price: 423.04)
        portfolio.addInstrument(symbol: "Barclays", price: 0.94)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80.0
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolio.prices.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > 1 {
            // Instrument Cell
            let index = indexPath.row - 2
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "InstrumentCell") as! InstrumentsCell
            let symbol = portfolio.getSymbol(index: index)
            cell.instrumentLabel.text = symbol
            cell.priceLabel.text = "\(portfolio.prices[symbol]!)"
            
            return cell
        } else {
            // Performance Cell
            let index = indexPath.row
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PerformanceCell") as! PerformanceCell
            if index == 0 {
                let timeFrame = "All Time"
                cell.performanceLabel.text = timeFrame
                cell.profitLabel.text = performance[timeFrame]
            } else {
                let timeFrame = "One month"
                cell.performanceLabel.text = timeFrame
                cell.profitLabel.text = performance[timeFrame]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
