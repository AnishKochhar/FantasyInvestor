//
//  sellView.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 30/11/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class sellView: UIView {
    
    var stock: StockInfo?
    var amount: Double?
    let formatter = NumberFormatter()
    
    lazy var buttonView: UIButton = {
        let button = UIButton()
        let amountString = formatter.string(from: NSNumber(value: amount! * stock!.currentPrice))!
        button.setTitle("Sell $\(amountString)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sellStock), for: .touchUpInside)
        return button
    }()
    
    @objc func sellStock() {
        guard let symbol = stock?.symbol else { return }
        
        if (portfolio.checkIfExists(target: symbol)) { displayMessage(title: "Error!", message: "You do not have any shares of \(symbol)"); return }
        
        portfolio.sellInstrument(symbol: symbol, value: amount! * stock!.currentPrice)
        
        displayMessage(title: "Success!", message: "You have sold all of your shares of \(symbol)!")
    }
    
    func displayMessage(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self
            presenter.sourceRect = self.bounds
        }
        window?.rootViewController?.present(alertView, animated: true, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        amount = portfolio.getAmount(symbol: stock!.symbol)
        
        self.backgroundColor = .magenta
        addSubview(buttonView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            buttonView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            buttonView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
}
