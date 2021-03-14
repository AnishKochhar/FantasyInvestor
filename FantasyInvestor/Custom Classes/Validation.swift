//
//  Validation.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 21/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

/*
 Validates user input
 */

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
    
    func checkNoSpacesInString(string: String) -> Bool {
        if string.contains(" ") { return false }
        else { return true }
    }
    
    func checkAll(username: String, email: String, password: String) -> Bool {
        if self.checkNotEmpty(string: username) && self.checkNotEmpty(string: password) && self.checkNotEmpty(string: email) && self.checkUsernameLength(username: username) && self.checkEmailContainsAt(email: email) && self.checkNoSpacesInString(string: username) && self.checkNoSpacesInString(string: password) {
            return true
        }
        else { return false }
    }
}

