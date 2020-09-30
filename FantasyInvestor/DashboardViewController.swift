//
//  DashboardViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 22/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    var portfolio: Portfolio = Portfolio(prices: [String: Double](), profit: 0.0)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var balanceBackgroundView: UIView!
    
    var distanceBetweenLineViewAndBalanceLabel: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portfolio.addInstrument(symbol: "Amazon", price: 3077.96)
        portfolio.addInstrument(symbol: "Apple", price: 111.90)
        portfolio.addInstrument(symbol: "Tesla", price: 423.04)
        portfolio.addInstrument(symbol: "Barclays", price: 0.94)
        portfolio.addInstrument(symbol: "Disney", price: 3077.96)
        portfolio.addInstrument(symbol: "Google", price: 111.90)
        portfolio.addInstrument(symbol: "Bet365", price: 423.04)
        portfolio.addInstrument(symbol: "Yahoo", price: 0.94)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 80
        self.scrollView.delegate = self
        
        calculateDistance()
    }
    
    func calculateDistance() {
        distanceBetweenLineViewAndBalanceLabel = self.lineView.frame.minY - self.balanceLabel.frame.maxY
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] {
                
                let newSize = newValue as! CGSize
                self.tableHeight.constant = newSize.height
            }
        }
    }
}


extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolio.prices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "InstrumentCell") as? InstrumentsCell else {
            return UITableViewCell()
        }
        let symbol = portfolio.getSymbol(index: index)
        cell.instrumentLabel.text = symbol
        cell.priceLabel.text = "$\(portfolio.prices[symbol]!)"
        
        return cell
    }
}

extension DashboardViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = self.scrollView.contentOffset
        let backgroundFrame = self.balanceBackgroundView.frame
        self.balanceBackgroundView.frame = CGRect(x: backgroundFrame.minX, y: offset.y, width: backgroundFrame.width, height: backgroundFrame.height)
    }
    
}
