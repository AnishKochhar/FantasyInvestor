//
//  AddInstrumentsCollectionViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 12/10/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

/*
 This class is responsible for:
    a) Getting the stock's image + name from Back4App
    b) Presenting this data in a UICollectionView
*/

import UIKit
import Parse

class AddInstrumentsCollectionViewController: UICollectionViewController {
    
    var instruments = [Stock]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInstruments()
    }

    func loadInstruments() {
        let query = PFQuery(className: "Instruments")
        query.findObjectsInBackground() { (objects: [PFObject]?, error: Error?) in
            if (error != nil) {
                print(error!)
            } else {
                for object in objects! {
                    self.instruments.append(Stock(pfObject: object))
                }
            }
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instruments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StocksCell", for: indexPath) as! StocksCell
        let stock = instruments[indexPath.row]
        cell.stockSymbolLabel.text = stock.symbol
        stock.image?.getDataInBackground() { (data, error) in
            if let imageData = data {
                cell.stockImageView.image = UIImage(data: imageData)
            }
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedCell = collectionView.indexPathsForSelectedItems?.first else { return }
        if let target = segue.destination as? InstrumentDetailViewController {
            target.stock = currentStocks[selectedCell.row]
        }
    }
}
