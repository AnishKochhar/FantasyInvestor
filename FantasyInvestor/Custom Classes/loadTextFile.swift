//
//  loadTextFile.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 13/10/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation
import Parse

protocol textFileDownloadDelegate {
    func didFinishDownloading(_ sender: loadTextFile)
}

class loadTextFile {
    
    var stocks: [StockInfo]?
    var responseDaily: [ResponseDaily]?
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
                    default:
                        return
                    }
                    DispatchQueue.main.async {
                        self.didFinishDownload()
                    }
                } catch {
                    print(error)
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
    
    func didFinishDownload() {
        delegate?.didFinishDownloading(self)
    }
}

