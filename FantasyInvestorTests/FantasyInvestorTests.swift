//
//  FantasyInvestorTests.swift
//  FantasyInvestorTests
//
//  Created by Anish Kochhar on 14/09/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import XCTest
@testable import FantasyInvestor

class FantasyInvestorTests: XCTestCase {
    
    var validation: Validation!
    
    override func setUp() {
        super.setUp()
        validation = Validation()
    }

    func testValidatorReturnsFalseWhenGivenTooShortUsername() {
        // 1. given
        let username = "de"
        let password = "validpassword"
        let email = "testemail@gmail.com"
        // 2. when
        let validDetails = validation.checkAll(username: username, email: email, password: password)
        // 3. then
        XCTAssertEqual(validDetails, false)
    }
    
    func testValidatorReturnsFalseWhenGivenTooLongUsername() {
        // 1. given
        let username = "veryLongUsernamePerhapsTooLong"
        let password = "validpassword"
        let email = "testemail@gmail.com"
        // 2. when
        let validDetails = validation.checkAll(username: username, email: email, password: password)
        // 3. then
        XCTAssertEqual(validDetails, false)
    }
    
    func testValidatorReturnsFalseWhenGivenInvalidEmail() {
        // 1. given
        let username = "validUsername"
        let password = "validpassword"
        let email = "testemail.com"
        // 2. when
        let validDetails = validation.checkAll(username: username, email: email, password: password)
        // 3. then
        XCTAssertEqual(validDetails, false)
    }
    
    func testValidatorReturnsFalseWhenGivenEmptyUsername() {
        // 1. given
        let username = ""
        let password = "validpassword"
        let email = "testemail@gmail.com"
        // 2. when
        let validDetails = validation.checkAll(username: username, email: email, password: password)
        // 3. then
        XCTAssertEqual(validDetails, false)
    }
    
    func testValidatorReturnsFalseWhenGivenEmptyPassword() {
        // 1. given
        let username = "validUsername"
        let password = ""
        let email = "testemail@gmail.com"
        // 2. when
        let validDetails = validation.checkAll(username: username, email: email, password: password)
        // 3. then
        XCTAssertEqual(validDetails, false)
    }
    
    func testValidatorReturnsFalseWhenGivenEmptyEmail() {
        // 1. given
        let username = "validUsername"
        let password = "validPassword"
        let email = ""
        // 2. when
        let validDetails = validation.checkAll(username: username, email: email, password: password)
        // 3. then
        XCTAssertEqual(validDetails, false)
    }
    
    func testValidatorReturnsTrueWhenGivenAllValidInputs() {
        // 1. given
        let username = "validUsername"
        let password = "validPassword"
        let email = "testemail@gmail.com"
        // 2. when
        let validDetails = validation.checkAll(username: username, email: email, password: password)
        // 3. then
        XCTAssertEqual(validDetails, true)
    }
    
    func testValidatorReturnsFalseWhenPasswordContainsSpace() {
        // 1. given
        let username = "validUsername"
        let password = "space here"
        let email = "testemail@gmail.com"
        // 2. when
        let validDetails = validation.checkAll(username: username, email: email, password: password)
        // 3. then
        XCTAssertEqual(validDetails, false)
    }
    

}

