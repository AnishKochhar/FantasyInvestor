//
//  AddInstrumentsCollectionViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 12/10/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit
import Parse

class AddInstrumentsCollectionViewController: UICollectionViewController, textFileDownloadDelegate {
    
    var stocks: [StockInfo]?
    var instruments = [Stock]()
    
    var textFileLoader: loadTextFile?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFileLoader = loadTextFile()
        textFileLoader?.delegate = self
        textFileLoader?.loadStockData()
        
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
        }
    }
    
    func didFinishDownloading(_ sender: loadTextFile) {
        self.stocks = textFileLoader?.stocks
        self.collectionView.reloadData()
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

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
