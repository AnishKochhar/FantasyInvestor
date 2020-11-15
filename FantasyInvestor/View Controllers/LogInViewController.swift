//
//  LogInViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 20/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var defaultEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.text = defaultEmail

        self.emailField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.passwordField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func logIn(_ sender: Any) {
    }
    
    @IBAction func switchToSignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { fatalError("Could not instantiate SignUpViewController") }
        
        let email = emailField.text ?? ""
        newVC.defaultEmail = email
        
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true)
    }
    
}
