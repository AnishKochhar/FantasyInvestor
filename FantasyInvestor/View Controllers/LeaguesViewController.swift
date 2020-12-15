//
//  LeaguesViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 15/12/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var leagueTableView: UITableView!
    let dummyData = [League(name: "Premier League", position: 1), League(name: "Ligue 1", position: 3), League(name: "Bundesliga", position: 2), League(name: "La Liga", position: 5)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        
        print(leagueTableView.rowHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = leagueTableView.dequeueReusableCell(withIdentifier: "LeagueCell") as? LeagueTableViewCell else { return UITableViewCell() }
        let league = dummyData[indexPath.row]
        cell.leagueName.text = "\(league.name)"
        cell.leaguePosition.text = "#\(league.position)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }

}

