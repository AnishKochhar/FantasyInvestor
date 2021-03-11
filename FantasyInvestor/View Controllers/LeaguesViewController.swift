//
//  LeaguesViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 15/12/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

/*
    a) Creating a league
        - Generates a code for the League
        - Prompts for League name
        - Adds League to Back4App Leagues
 
    b) Joining a league
        - Prompts for code
        - Checks in Back4App for that code, responding with match
        - Adds this user ID to that League in Back4App if so

*/

import UIKit
import Parse

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var leagueTableView: UITableView!
    var leagueLoader: loadLeagues?
    
    var leagues = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        
        leagueLoader = loadLeagues()
        leagueLoader?.delegate = self

        for code in portfolio.getLeagues() {
            leagueLoader?.getLeagueData(code: code)
            leagueLoader = loadLeagues()
            leagueLoader?.delegate = self
        }
        
        leagueTableView.rowHeight = 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = leagueTableView.dequeueReusableCell(withIdentifier: "LeagueCell") as? LeagueTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        cell.leagueName.text = "\(leagues[index].name)"
        cell.leaguePosition.text = "#\(leagues[index].position ?? 0)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        assert(segue.identifier == "LeagueDetail")
        
        guard let vc = segue.destination as? LeagueDetailViewController else { return }
        vc.currentLeague = leagues[leagueTableView.indexPathForSelectedRow?.row ?? 0]
    }
}

// MARK: leagueLoaderDelegate
extension LeaguesViewController: leagueLoaderDelegate {
    
    func didFinishDownloading(_ sender: loadLeagues) {
        let data = sender.newLeague
        leagues.append(data)
        let indexPath = IndexPath(row: leagues.count - 1, section: 0)
        leagueTableView.insertRows(at: [indexPath], with: .automatic)
    }
}

// MARK: Creating / Joining
extension LeaguesViewController {
    
    @IBAction func createLeague(_ sender: Any) {
        let newCode = "XY21"
        let newName = "Serie A"
        let ac = UIAlertController(title: "New League Created!", message: "Your league name is '\(newName)'\nCode: \(newCode)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        ac.addAction(action)
        
        present(ac, animated: true)
        let currentUser = User(id: portfolio.getID(), username: portfolio.getID(), profit: portfolio.balance)
        let newLeague = League(name: newName, users: [currentUser], position: 1)
        
        leagues.append(newLeague)
        leagueTableView.reloadData()
    }
    
    @IBAction func joinLeague(_ sender: Any) {
        
    }
    
}
