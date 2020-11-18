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

    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var buttonView: UIButton = {
        let button = UIButton()
        let amount = numberFormatter.string(from: NSNumber(value: portfolio.balance * 0.1))!
        button.setTitle("Buy $\(amount)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(2, inComponent: 0, animated: false)
        
        backgroundColor = .orange
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
            labelView.heightAnchor.constraint(equalToConstant: 50),

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
            let amount = numberFormatter.string(from: NSNumber(value: portfolio.balance * 0.02))!
            buttonView.setTitle("Buy $\(amount)", for: .normal)
            
        }
        if (row == 1) {
            let amount = numberFormatter.string(from: NSNumber(value: portfolio.balance * 0.05))!
            buttonView.setTitle("Buy $\(amount)", for: .normal)
            
        }
        if (row == 2) {
            let amount = numberFormatter.string(from: NSNumber(value: portfolio.balance * 0.1))!
            buttonView.setTitle("Buy $\(amount)", for: .normal)
            
        }
        if (row == 3) {
            let amount = numberFormatter.string(from: NSNumber(value: portfolio.balance * 0.15))!
            buttonView.setTitle("Buy $\(amount)", for: .normal)
        }
        if (row == 4) {
            let amount = numberFormatter.string(from: NSNumber(value: portfolio.balance * 0.2))!
            buttonView.setTitle("Buy $\(amount)", for: .normal)
            
        }
    }
}
