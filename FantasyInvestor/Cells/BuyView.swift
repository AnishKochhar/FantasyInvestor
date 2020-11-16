//
//  BuyView.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 15/11/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class buyView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    lazy var buttonView: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Confirm"
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var labelView: UILabel = {
        let label = UILabel()
        label.text = "How much of your balance are you going to invest?"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
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
        pickerView.dataSource = self
        pickerView.delegate = self
        
        backgroundColor = .orange
        addSubview(buttonView)
        addSubview(pickerView)
        addSubview(labelView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: topAnchor),
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelView.heightAnchor.constraint(equalToConstant: 40),

            pickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: labelView.bottomAnchor),
            pickerView.widthAnchor.constraint(equalToConstant: 100),
            pickerView.heightAnchor.constraint(equalToConstant: 300),

//            buttonView.topAnchor.constraint(equalTo: pickerView.topAnchor),
            buttonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
                return "1 %"
            case 1:
                return "5 %"
            case 2:
                return "10 %"
            case 3:
                return "25 %"
            default:
                return "50 %"
        }
    }
}
