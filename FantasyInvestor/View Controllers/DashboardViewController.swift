//
//  DashboardViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 22/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit
import Parse

class DashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var balanceBackgroundView: UIView!
    
    var distanceBetweenLineViewAndBalanceLabel: CGFloat = 0
    let formatter = NumberFormatter()
    
    var textFileLoader: loadTextFile?
    
    let currentUserID = PFUser.current()!.objectId!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        getPortfolio()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 80
        self.scrollView.delegate = self
        tableView.layer.cornerRadius = 5.0
        
        calculateDistance()
        blurBackground()
        
        textFileLoader = loadTextFile()
        textFileLoader?.delegate = self
        textFileLoader?.loadStockData()
    }

    func calculateDistance() {
        distanceBetweenLineViewAndBalanceLabel = self.lineView.frame.minY - self.balanceLabel.frame.maxY
    }
    
    func blurBackground() {
        balanceBackgroundView.backgroundColor = .clear
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blur.frame = balanceBackgroundView.frame
        blur.isUserInteractionEnabled = false
        blur.clipsToBounds = true
        balanceBackgroundView.addSubview(blur)
        balanceBackgroundView.sendSubviewToBack(blur)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tableView.reloadData()
        self.displayBalance()
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

extension DashboardViewController {
    
    func getPortfolio() {
        let query = PFQuery(className: "Portfolio")
        
        query.whereKey("User", equalTo: currentUserID)
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                self.updatePortfolioWithReturnedObjects(objects: objects)
            } else {
                if let descrip = error?.localizedDescription {
                    self.displayErrorMessage(message: descrip)
                }
            }
        }
    }
    
    func updatePortfolioWithReturnedObjects(objects: [PFObject]) {
        let userPortfolio = objects[0]
        let instruments = userPortfolio["Instruments"] as! [String]
        let prices = userPortfolio["Prices"] as! [Double]
        let volumes = userPortfolio["Volumes"] as! [Double]
        let balance = userPortfolio["Balance"] as! Double
        let id = userPortfolio["User"] as! String
        let leagues = userPortfolio["Leagues"] as! [String]
        assert(instruments.count == prices.count)
        for i in 0 ..< instruments.count {
            portfolio.addInstrument(symbol: instruments[i], price: prices[i], amount: volumes[i])
        }
        portfolio.setBalance(balance: balance)
        portfolio.setId(id: id)
        portfolio.updateLeagues(leagues: leagues)
        
        self.tableView.reloadData()
        self.displayBalance()
    }
    
    func displayErrorMessage(message: String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion: nil)
    }
    
    func displayBalance() {
        let balanceString = formatter.string(from: NSNumber(value: portfolio.balance))!
        self.balanceLabel.text = "Balance: $\(balanceString)"
    }
}

extension DashboardViewController: textFileDownloadDelegate {
    
    func didFinishDownloading(_ sender: loadTextFile) {
        currentStocks = sender.stocks!
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
        var currentPrice = 0.0
        cell.instrumentLabel.text = symbol
        cell.priceLabel.text = "$\(portfolio.prices[symbol]!.0)"
        for stock in currentStocks {
            if stock.symbol == symbol {
                currentPrice = stock.currentPrice
            }
        }
//        cell.profitPercentageLabel.text = "\((currentPrice - portfolio.prices[symbol]!.0) / (portfolio.prices[symbol]!.0))"
        cell.profitPercentageLabel.text = "Percentage Profit"
        
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
