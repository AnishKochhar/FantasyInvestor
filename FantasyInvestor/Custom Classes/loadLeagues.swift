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
    
    var finalData: [User]?
    var newLeague = League(name: "", users: [], position: nil)
    var code: String?
    var delegate: leagueLoaderDelegate?
    
    func getUserProfit(_ userID: String) -> Int {
        return 100
    }
    
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
                if let users = objects[0]["Users"] as? [String] {
                    for userID in users {
                        let newUser = User(id: userID, username: userID, profit: 0)
                        newUser.setProfit(self.getUserProfit(userID))
                        data.append(newUser)
                    }
                    self.newLeague.users = data.sorted(by: { $0.profit > $1.profit })
                }
                DispatchQueue.main.async {
                    self.didFinishDownload()
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
    
    func didFinishDownload() {
        self.newLeague.name = self.code ?? ""
        findLeaguePosition()
        delegate?.didFinishDownloading(self)
    }
}

