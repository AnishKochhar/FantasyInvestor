//
//  ViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 14/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var defaultEmail = ""
    let validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailField.text = defaultEmail
        
        self.usernameField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.emailField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.passwordField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        let email = emailField.text!
        
        if validation.checkAll(username: username, email: email, password: password) {
            // Check they aren't in use in the database

        }
    }
    
    @IBAction func switchToLogIn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController else { fatalError("Could not instantiate the LogInViewController") }
        
        let email = emailField.text ?? ""
        newVC.defaultEmail = email
        
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true)
    }
    
}

