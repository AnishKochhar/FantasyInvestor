//
//  ViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 14/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit
import Parse

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
    
    override func viewWillAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        if currentUser != nil {
            loadDashboard()
        }
    }
    
    func loadDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardViewController = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        UIApplication.shared.windows.first?.rootViewController = dashboardViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        let email = emailField.text!
        
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        
        if validation.checkAll(username: username, email: email, password: password) {
            user.signUpInBackground { (success, error) in
                if success {
                    self.createDefaultPortfolio(userID: user.objectId!)
                    self.loadDashboard()
                } else {
                    if let descrip = error?.localizedDescription {
                        self.displayErrorMessage(message: descrip)
                    }
                }
            }
        } else {
            self.displayErrorMessage(message: "Invalid fields")
        }
    }
    
    func createDefaultPortfolio(userID: String) {
        let portfolio = PFObject(className: "Portfolio")
        
        portfolio["User"] = userID
        portfolio["Instruments"] = ["Apple", "Amazon"]
        portfolio["Prices"] = [111.90, 1034.32]
        
        portfolio.saveInBackground { (success, error) in
            if !success {
                if let descrip = error?.localizedDescription {
                    self.displayErrorMessage(message: descrip)
                }
            }
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
    
}

