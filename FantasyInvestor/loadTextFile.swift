//
//  loadTextFile.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 13/10/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import Foundation
import Parse

class loadTextFile {
    
    var textFileName: String
    
    init(name: String) {
        self.textFileName = name
    }
    
    func downloadTextFile() {
        let query = PFQuery(className: "TextFiles")
        query.whereKey("Name", equalTo: textFileName)
        query.findObjectsInBackground { (objects, error) in
            
            if let error = error {
                print("Error: \(error) \(error.localizedDescription)")
                return
            }
            if let objects = objects {
                if let file = objects[0]["File"] as? PFFileObject {
                    self.getTextData(file: file)
                }
            }
        }
    }
    
    func getTextData(file: PFFileObject) {
        file.getDataInBackground(block: { (fileData, error) in
            if let fileData = fileData {
                print(fileData)
            }
        })
    }
    
    
    
}

