//
//  loadLeagues.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 01/03/2021.
//  Copyright © 2021 Anish Kochhar. All rights reserved.
//

import Foundation
import Parse

protocol leagueLoaderDelegate {
    func didFinishDownloading(_ sender: loadLeagues)
}

class loadLeagues {
    
    var newLeague = League(name: "", users: [], position: nil)
    var code: String?
    var delegate: leagueLoaderDelegate?
    var returned = 0
    
    func getLeagueData(code: String) {
        self.code = code
        var data = [User]()
        let query = PFQuery(className: "League")
        query.whereKey("Code", equalTo: code)
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print("Error: \(error) \(error.localizedDescription)")
                return
            }
            if let objects = objects {
                if let name = objects[0]["Name"] as? String {
                    self.newLeague.name = name
                }
                if let users = objects[0]["Users"] as? [String] {
                    for i in 0..<users.count {
                        let userID = users[i]
                        let newUser = User(id: userID, username: userID, profit: 0)
                        data.append(newUser)
                    }
                    self.newLeague.users = data
                }
                DispatchQueue.main.async {
                    self.didFinishDownload()
                }
            }
        }
    }
    
    func getUserProfit(_ userID: String, index: Int,  _ closure: @escaping () -> Void) {
        let query = PFQuery(className: "Portfolio")
        query.whereKey("User", equalTo: userID)
        
        query.findObjectsInBackground { (objects, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let objects = objects {
                if let balance = objects[0]["Balance"] as? Double {
                    self.newLeague.users[index].profit = balance
                    self.returned += 1
                    if self.returned == self.newLeague.users.count {
                        closure()
                    }
                }
            }
        }
    }
    
    
    func findLeaguePosition() {
        let user = PFUser.current()!.objectId!
        for i in 0..<self.newLeague.users.count {
            if self.newLeague.users[i].id == user {
                self.newLeague.position = i + 1
            }
        }
    }
    
    func getBalances() {
        let n = self.newLeague.users.count
        for i in 0..<n {
            self.getUserProfit(self.newLeague.users[i].id, index: i) {
                DispatchQueue.main.async {
                    self.newLeague.users.sort(by: { $0.profit > $1.profit })
                    self.findLeaguePosition()
                    self.delegate?.didFinishDownloading(self)
                }
            }
        }
    }
    
    func didFinishDownload() {
        self.getBalances()
    }
}

