//
//  DashboardViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 22/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var portfolio: Portfolio = Portfolio(prices: [String: Double](), profit: 0.0)

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portfolio.addInstrument(symbol: "Amazon", price: 3077.96)
        portfolio.addInstrument(symbol: "Apple", price: 111.90)
        portfolio.addInstrument(symbol: "Tesla", price: 423.04)
        portfolio.addInstrument(symbol: "Barclays", price: 0.94)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "InstrumentCell") as! InstrumentsCell
        print("im here")
        let symbol = portfolio.getSymbol(index: index)
        cell.instrumentLabel.text = symbol
        cell.priceLabel.text = "$\(portfolio.prices[symbol]!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolio.prices.count
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
