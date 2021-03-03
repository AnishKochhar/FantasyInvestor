//
//  LeagueDetailViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 02/03/2021.
//  Copyright © 2021 Anish Kochhar. All rights reserved.
//

import UIKit

class LeagueDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var leagueNameLabel: UILabel!
    @IBOutlet weak var leagueDetailTable: UITableView!
    
    var currentLeague: League?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueDetailTable.delegate = self
        leagueDetailTable.dataSource = self
        
        leagueDetailTable.rowHeight = 75

        leagueNameLabel.text = "\(currentLeague?.name ?? "Nil")"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentLeague?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = leagueDetailTable.dequeueReusableCell(withIdentifier: "LeagueDetailTableCell") as? LeagueDetailTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = "#\(indexPath.row + 1). \(currentLeague?.users[indexPath.row].id ?? "Nil")"
        cell.balanceLabel.text = "$\(currentLeague?.users[indexPath.row].profit ?? 0.0)"
        
        return cell
    }

}
