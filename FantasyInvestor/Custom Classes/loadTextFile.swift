//
//  loadTextFile.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 13/10/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

/*
 Downloads all of the text files from the database
 
 First uses Parse to get them, then Parse to convert that file to JSON, then JSONDecoder to convert that JSON into Swift objects
 */

import Foundation
import Parse

protocol textFileDownloadDelegate {
    func didFinishDownloading(_ sender: loadTextFile)
}


class loadTextFile {
    
    var stocks: [StockInfo]?
    var responseDaily: [ResponseDaily]?
    var responseWeekly: [ResponseWeekly]?
    var response5min: [Response5min]?
    var response30min: [Response30min]?
    var delegate: textFileDownloadDelegate?
    
    
    func downloadTextFile(name: String) {
        let query = PFQuery(className: "TextFiles")
        query.whereKey("Name", equalTo: name)
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print("Error: \(error) \(error.localizedDescription)")
                return
            }
            if let objects = objects {
                if let file = objects[0]["File"] as? PFFileObject {
                    self.turnIntoSwiftData(file: file, name: name)
                }
            }
        }
    }
    
    func turnIntoSwiftData(file: PFFileObject, name: String) {
        file.getDataInBackground(block: { (fileData, error) in
            if let fileData = fileData {
                do {
                    switch (name) {
                    case "Instruments.txt":
                        let stocks = try JSONDecoder().decode([StockInfo].self, from: fileData)
                        self.stocks = stocks
                    case "1day.txt":
                        let responseDaily = try JSONDecoder().decode([ResponseDaily].self, from: fileData)
                        self.responseDaily = responseDaily
                    case "1week.txt" :
                        let responseWeekly = try JSONDecoder().decode([ResponseWeekly].self, from: fileData)
                        self.responseWeekly = responseWeekly
                    case "5min.txt" :
                        let response5min = try JSONDecoder().decode([Response5min].self, from: fileData)
                        self.response5min = response5min
                    case "30min.txt" :
                        let response30min = try JSONDecoder().decode([Response30min].self, from: fileData)
                        self.response30min = response30min
                    default:
                        print("Invalid name: \(name)")
                        return
                    }
                    DispatchQueue.main.async {
                        self.didFinishDownload()
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        })
    }

    
    func loadStockData() {
        if (self.stocks == nil) {
            self.downloadTextFile(name: "Instruments.txt")
        } else {
            self.didFinishDownload()
        }
    }
    
    func loadYearData() {
        if (self.responseDaily == nil) {
            self.downloadTextFile(name: "1day.txt")
        } else {
            self.didFinishDownload()
        }
    }
    
    func load5YearData() {
        if (self.responseWeekly == nil) {
            self.downloadTextFile(name: "1week.txt")
        } else {
            self.didFinishDownload()
        }
    }
    
    func loadDayData() {
        if (self.response5min == nil) {
            self.downloadTextFile(name: "5min.txt")
        } else {
            self.didFinishDownload()
        }
    }
    
    func loadWeekData() {
        if (self.response30min == nil) {
            self.downloadTextFile(name: "30min.txt")
        } else {
            self.didFinishDownload()
        }
    }
    
    func didFinishDownload() {
        delegate?.didFinishDownloading(self)
    }
}

