//
//  InstrumentDetailViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 04/11/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit
import Charts

class InstrumentDetailViewController: UIViewController {
    
    @IBOutlet weak var instrumentNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var descriptionBoxLabel: UILabel!
    
    @IBOutlet weak var lineChart: LineChartView!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
    
    var stock: StockInfo?
    
    var slideupView = buyView()
    let slideupViewHeight: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let stock = stock {
            instrumentNameLabel.text = stock.name
            priceLabel.text = "\(stock.currentPrice)"
            symbolLabel.text = stock.symbol
            marketCapLabel.text = stock.marketCap
            foundedLabel.text = "\(stock.yearFounded)"
            descriptionBoxLabel.text = stock.description
        }
        
        setupButtons()
    }
    
    func setupButtons() {
        buyButton.layer.borderWidth = 2.0
        buyButton.layer.borderColor = CGColor(srgbRed: 155/255, green: 17/255, blue: 30/255, alpha: 1)
        buyButton.layer.cornerRadius = 4
        sellButton.layer.borderWidth = 2.0
        sellButton.layer.borderColor = CGColor(srgbRed: 155/255, green: 17/255, blue: 30/255, alpha: 1)
        sellButton.layer.cornerRadius = 4
    }
    
    @IBAction func buyPressed(_ sender: Any) {
        let screenSize = view.bounds.size
        slideupView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: slideupViewHeight)
        slideupView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(slideupView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.slideupView.frame = CGRect(x: 0, y: screenSize.height - self.slideupViewHeight, width: screenSize.width, height: self.slideupViewHeight)
            self.view.backgroundColor = .lightGray
        }, completion: nil)
        
    }
    
    @IBAction func sellPressed(_ sender: Any) {
    }
}

