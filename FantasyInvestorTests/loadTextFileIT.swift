//
//  loadTextFileIT.swift
//  FantasyInvestorTests
//
//  Created by Anish Kochhar on 03/03/2021.
//  Copyright © 2021 Anish Kochhar. All rights reserved.
//

/*
Integration Tests for textFileLoader
 Tests:
    a) Works with valid JSON + matching name string
    b) Fails with valid JSON + non-matching name
    c) Fails with invalid JSON
 - name string refers to the name of the .txt file we are downloading, which determines what type we should decode it into.
 */


import XCTest
import Parse
@testable import FantasyInvestor

class loadTextFileIT: XCTestCase {
    
    class testClass: textFileDownloadDelegate {

        var textFileLoader = loadTextFile()
        var finished = false

        init() {
            textFileLoader.delegate = self
        }

        func callTurnIntoSwiftData(_ file: PFFileObject, name: String) {
            textFileLoader.turnIntoSwiftData(file: file, name: name)
        }

        func didFinishDownloading(_ sender: loadTextFile) {
            print("Success")
            finished = true
        }
    }

    func testGivenValidJsonWhenTurnIntoSwiftDataCalledThenNoErrorThrown() {
        // 1. given
        let sampleJson = """
                    [
                        {
                            "Symbol": "AAPL",
                            "Time Series (5min)": {
                                "2020-12-14 20:00:00": {
                                    "1. open": "121.8900",
                                    "2. high": "121.8900",
                                    "3. low": "121.8400",
                                    "4. close": "121.8900",
                                    "5. volume": "4496"
                                },
                                "2020-12-14 19:55:00": {
                                    "1. open": "121.9100",
                                    "2. high": "121.9100",
                                    "3. low": "121.8000",
                                    "4. close": "121.8900",
                                    "5. volume": "6522"
                                },
                                "2020-12-14 11:45:00": {
                                    "1. open": "122.7200",
                                    "2. high": "122.8400",
                                    "3. low": "122.6800",
                                    "4. close": "122.7880",
                                    "5. volume": "482489"
                                }
                            }
                        }
                    ]
        """
        let pfFileObject = PFFileObject(data: Data(sampleJson.utf8))
        if (pfFileObject == nil) {
            assert(false)
        }
        
        let tester = testClass()

        // 2. when
        tester.callTurnIntoSwiftData(pfFileObject!, name: "5min.txt")
        
        // 3. then
        XCTAssert(tester.finished)
    }
    
    func testGivenInalidJsonWhenTurnIntoSwiftDataCalledThenErrorThrown() {
        // 1. given
        let sampleJson = """
                    [
                        {
                            "Symbol": "AAPL",
                            "Time Series (5min)": {
                                "2020-12-14 20:00:00": {
                                    "1. open": "121.8900",
                                    "2. high": "121.8900",
                                    "3. low": "121.8400",
                                    "4. close": "121.8900",
                                    "5. volume": "4496"
                                },
                                "2020-12-14 19:55:00": {
                                    "1. open": "121.9100",
                                    "2. high": "121.9100",
                                    "3. low": "121.8000",
                                    "4. close": "121.8900",
                                    "5. volume": "6522"
                                },
                                "2020-12-14 11:45:00": {
                                    "1. open": "122.7200",
                                    "2. high": "122.8400",
                                    "3. low": "122.6800",
                                    "4. close": "122.7880",
                                    "5. volume": "482489"
                                }
                            }
                        }
                    ]
        """
        let pfFileObject = PFFileObject(data: Data(sampleJson.utf8))
        if (pfFileObject == nil) {
            assert(false)
        }
        
        let tester = testClass()

        // 2. when
        tester.callTurnIntoSwiftData(pfFileObject!, name: "30min.txt")
        
        // 3. then
        XCTAssert(!tester.finished)
    }
    
    func testGivenValidJsonWithWrongNameWhenTurnIntoSwiftDataCalledThenErrorThrown() {
        // 1. given

        // 2. when
        
        // 3. then
        
    }

}

