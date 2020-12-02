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
    
    var slideupBuyView = buyView()
    var slideupSellView: sellView?
    let slideupViewHeight: CGFloat = 315
    
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
        slideupBuyView.stock = self.stock
        let screenSize = view.bounds.size
        slideupBuyView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: slideupViewHeight)
        
        view.addSubview(slideupBuyView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.slideupBuyView.frame = CGRect(x: 0, y: screenSize.height - self.slideupViewHeight, width: screenSize.width, height: self.slideupViewHeight)
            self.view.backgroundColor = .lightGray
        }, completion: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func sellPressed(_ sender: Any) {
        slideupSellView = sellView()
        slideupSellView!.stock = self.stock
        slideupSellView!.setupView()
        let screenSize = view.bounds.size
        slideupSellView!.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: slideupViewHeight)
        
        view.addSubview(slideupSellView!)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.slideupSellView!.frame = CGRect(x: 0, y: screenSize.height - self.slideupViewHeight, width: screenSize.width, height: self.slideupViewHeight)
            self.view.backgroundColor = .lightGray
        }, completion: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: Objc func
    @objc func dismissView() {
        let screenSize = view.bounds.size
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.slideupBuyView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.slideupViewHeight)
            self.slideupSellView!.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.slideupViewHeight)
            self.view.backgroundColor = .systemBackground
        }, completion: nil)
    }
}

