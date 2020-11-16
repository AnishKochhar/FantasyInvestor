//
//  BuyView.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 15/11/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class buyView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.frame = CGRect(x: 0, y: 40, width: 300, height: 260)
        return picker
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        button.titleLabel?.text = "Confirm"
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.titleLabel?.textAlignment = .center
        return button
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
        picker.dataSource = self
        picker.delegate = self
        
        backgroundColor = .orange
        addSubview(picker)
        addSubview(button)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 10
        } else {
            return 100
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "First \(row)"
        } else {
            return "Second \(row)"
        }
    }
}
