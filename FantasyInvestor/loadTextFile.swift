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
                    switch name {
                    case "Instruments.txt":
                        self.getStockData(file: file)
                    default:
                        return
                    }
                }
            }
        }
    }
    
    func getStockData(file: PFFileObject) {
        file.getDataInBackground(block: { (fileData, error) in
            if let fileData = fileData {
                do {
                    let stocks = try JSONDecoder().decode([StockInfo].self, from: fileData)
                    self.stocks = stocks
                    DispatchQueue.main.async {
                        self.didDownloadImage()
                    }
                    
                } catch {
                    print(error)
                }
            }
        })
    }
    
    func loadStockData() {
        self.downloadTextFile(name: "Instruments.txt")
    }
    
    func didDownloadImage() {
        delegate?.didFinishDownloading(self)
    }
}

