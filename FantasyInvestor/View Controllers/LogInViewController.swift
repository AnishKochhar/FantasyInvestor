//
//  LogInViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 20/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit
import Parse

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
    
    func loadDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardViewController = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        UIApplication.shared.windows.first?.rootViewController = dashboardViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @IBAction func logIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: emailField.text!, password: passwordField.text!) { (user, error) in
            if user != nil {
                self.loadDashboard()
            } else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: (descrip))
                }
            }
        }
    }
    
    @IBAction func switchToSignUp(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { fatalError("Could not instantiate SignUpViewController") }
        
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
