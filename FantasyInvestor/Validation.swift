//
//  Validation.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 21/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation

class Validation {

    func checkNotEmpty(string: String) -> Bool {
        if string != "" { return true }
        else { return false }
    }
    
    func checkUsernameLength(username: String) -> Bool {
        if username.count > 3 && username.count < 20 { return true }
        else { return false }
    }
    
    func checkEmailContainsAt(email: String) -> Bool {
        if email.contains("@") { return true }
        else { return false }
    }
    
    func checkAll(username: String, email: String, password: String) -> Bool {
        if self.checkNotEmpty(string: username) && self.checkNotEmpty(string: password) && self.checkNotEmpty(string: email) && self.checkUsernameLength(username: username) && self.checkEmailContainsAt(email: email) {
            return true
        }
        else { return false }
    }
}

