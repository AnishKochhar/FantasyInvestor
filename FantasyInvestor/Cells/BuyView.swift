//
//  BuyView.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 15/11/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class buyView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let numberFormatter = NumberFormatter()
    var amount = portfolio.balance * 0.1
    var stock: StockInfo?

    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var buttonView: UIButton = {
        let button = UIButton()
        let amountString = numberFormatter.string(from: NSNumber(value: amount))!
        button.setTitle("Buy $\(amountString)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buyStock), for: .touchUpInside)
        return button
    }()
    
    lazy var labelView: UILabel = {
        let label = UILabel()
        label.text = "Cash: $\(portfolio.balance)"
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var staticLabel: UILabel = {
        let label = UILabel()
        label.text = "of total portfolio"
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func buyStock() {
        guard let symbol = stock?.symbol else { return }
        guard let price = stock?.currentPrice else { return }
        
        if (!portfolio.checkIfExists(target: symbol)) { displayMessage(title: "Error!", message: "Stock already exists in your portfolio!"); return }
        
        portfolio.buyInstrument(symbol: symbol, price: price, amount: amount / price)
//        portfolio.updatePortfolio()
        displayMessage(title: "Success!", message: "You have bought $\(amount) of \(symbol)!")
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
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(2, inComponent: 0, animated: false)
        
        backgroundColor = .magenta
        addSubview(pickerView)
        addSubview(labelView)
        addSubview(buttonView)
        addSubview(staticLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            labelView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
//            labelView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
//            labelView.heightAnchor.constraint(equalToConstant: 50),

            pickerView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            pickerView.topAnchor.constraint(equalTo: labelView.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            pickerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            pickerView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5),
            
            staticLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            staticLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            staticLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),

            buttonView.topAnchor.constraint(equalTo: pickerView.bottomAnchor),
            buttonView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            buttonView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            buttonView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5)
        ])
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch (row) {
            case 0:
                return "2 %"
            case 1:
                return "5 %"
            case 2:
                return "10 %"
            case 3:
                return "15 %"
            default:
                return "20 %"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (row == 0) {
            amount = portfolio.balance * 0.02
            let amountString = numberFormatter.string(from: NSNumber(value: amount))!
            buttonView.setTitle("Buy $\(amountString)", for: .normal)
        }
        if (row == 1) {
            amount = portfolio.balance * 0.05
            let amountString = numberFormatter.string(from: NSNumber(value: amount))!
            buttonView.setTitle("Buy $\(amountString)", for: .normal)
        }
        if (row == 2) {
            amount = portfolio.balance * 0.1
            let amountString = numberFormatter.string(from: NSNumber(value: amount))!
            buttonView.setTitle("Buy $\(amountString)", for: .normal)
        }
        if (row == 3) {
            amount = portfolio.balance * 0.15
            let amountString = numberFormatter.string(from: NSNumber(value: amount))!
            buttonView.setTitle("Buy $\(amountString)", for: .normal)
        }
        if (row == 4) {
            amount = portfolio.balance * 0.2
            let amountString = numberFormatter.string(from: NSNumber(value: amount))!
            buttonView.setTitle("Buy $\(amountString)", for: .normal)
            
        }
    }
}
