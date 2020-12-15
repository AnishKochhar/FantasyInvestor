//
//  InstrumentDetailViewController.swift
//  FantasyInvestor
//
//  Created by Anish Kochhar on 04/11/2020.
//  Copyright © 2020 Anish Kochhar. All rights reserved.
//

import UIKit
import Charts

class InstrumentDetailViewController: UIViewController {
    
    @IBOutlet weak var instrumentNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var descriptionBoxLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
    
    var stock: StockInfo?
    var dataKeyValues = [(key: String, value: TimeSeriesProtocol)]()
    var currentTimeFrame = 2
    
    var textFileLoader: loadTextFile?
    
    var slideupBuyView = buyView()
    var slideupSellView: sellView?
    let slideupViewHeight: CGFloat = 315
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let stock = stock {
            instrumentNameLabel.text = stock.name
            priceLabel.text = "\(stock.currentPrice)"
            symbolLabel.text = stock.symbol
            marketCapLabel.text = stock.marketCap
            foundedLabel.text = "\(stock.yearFounded)"
            descriptionBoxLabel.text = stock.description
        }
        
        textFileLoader = loadTextFile()
        textFileLoader?.delegate = self
        textFileLoader?.loadYearData()
        
        setupButtons()
        setupGraph()
    }
    
    func setupButtons() {
        buyButton.layer.borderWidth = 2.0
        buyButton.layer.borderColor = CGColor(srgbRed: 155/255, green: 17/255, blue: 30/255, alpha: 1)
        buyButton.layer.cornerRadius = 4
        sellButton.layer.borderWidth = 2.0
        sellButton.layer.borderColor = CGColor(srgbRed: 155/255, green: 17/255, blue: 30/255, alpha: 1)
        sellButton.layer.cornerRadius = 4
    }
    
    @IBAction func segmentPressed(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            currentTimeFrame = 0
            textFileLoader?.loadDayData()
        case 1:
            currentTimeFrame = 1
            textFileLoader?.loadWeekData()
        case 2:
            currentTimeFrame = 2
            textFileLoader?.loadYearData()
        default:
            currentTimeFrame = 3
            textFileLoader?.load5YearData()
        }
    }
    
}

// MARK: textFileDownloadDelegate
extension InstrumentDetailViewController: textFileDownloadDelegate {
    
    func didFinishDownloading(_ sender: loadTextFile) {
        // loop through the responses, and find the one that matches the current stock
        switch (currentTimeFrame) {
        case 0:
            for response in sender.response5min! {
                if (response.symbol == self.stock?.symbol) {
                    self.dataKeyValues = response.timeSeries5min.sorted(by: { $0.key < $1.key })
                    self.dateLabel.text = self.dataKeyValues[self.dataKeyValues.count - 1].key
                    drawGraph(dataKeyValues: self.dataKeyValues)
                }
            }
        case 1:
            for response in sender.response30min! {
                if (response.symbol == self.stock?.symbol) {
                    self.dataKeyValues = response.timeSeries30min.sorted(by: { $0.key < $1.key })
                    self.dateLabel.text = self.dataKeyValues[self.dataKeyValues.count - 1].key
                    drawGraph(dataKeyValues: self.dataKeyValues)
                }
            }
        case 2:
            for response in sender.responseDaily! {
                if (response.symbol == self.stock?.symbol) {
                    self.dataKeyValues = response.timeSeriesDaily.sorted(by: { $0.key < $1.key })
                    self.dateLabel.text = self.dataKeyValues[self.dataKeyValues.count - 1].key
                    drawGraph(dataKeyValues: self.dataKeyValues)
                }
            }
        default:
            for response in sender.responseWeekly! {
                if (response.symbol == self.stock?.symbol) {
                    self.dataKeyValues = response.timeSeriesWeekly.sorted(by: { $0.key < $1.key })
                    self.dateLabel.text = self.dataKeyValues[self.dataKeyValues.count - 1].key
                    drawGraph(dataKeyValues: self.dataKeyValues)
                }
            }
        }
    }
}

// MARK: ChartViewDelegate + Graph Stuff
extension InstrumentDetailViewController: ChartViewDelegate {
    
    func setupGraph() {
        lineChart.delegate = self
        
        lineChart.backgroundColor = .clear
        lineChart.drawGridBackgroundEnabled = false
        lineChart.drawBordersEnabled = false
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.drawAxisLineEnabled = false
        lineChart.leftAxis.drawAxisLineEnabled = false
        
        lineChart.legend.enabled = false
        
        lineChart.rightAxis.enabled = false
        lineChart.xAxis.labelCount = 0
        lineChart.xAxis.labelTextColor = .clear
        
        lineChart.animate(xAxisDuration: 2)
    }
    
    func drawGraph(dataKeyValues: [(key: String, value: TimeSeriesProtocol)]) {
        var dataSet = [ChartDataEntry]()
        var i = 0
        let baseValue = dataKeyValues[0].value.close
        let finalValue = dataKeyValues[dataKeyValues.count - 1].value.close
        let fillColour: UIColor = (baseValue < finalValue ? .green : .red)
        let lineColour: UIColor = (baseValue < finalValue ? UIColor(red: 0, green: 215/255, blue: 0, alpha: 1) : UIColor(red: 240/255, green: 0, blue: 0, alpha: 1))
        
        for keyValue in dataKeyValues {
            let value = ChartDataEntry(x: Double(i), y: Double(keyValue.value.close)!)
            dataSet.append(value)
            i += 1
        }
        
        let set = LineChartDataSet(entries: dataSet)
        set.drawCirclesEnabled = false
        set.lineWidth = 3
        set.setColor(lineColour, alpha: 0.8)
        let gradientColors = [fillColour.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [0.3, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        set.fill = Fill.init(linearGradient: gradient!, angle: 90.0)
        
        set.drawFilledEnabled = true
        set.drawValuesEnabled = true
        set.valueTextColor = .black
        
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.highlightLineWidth = 1.5
        set.highlightColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        let data = LineChartData(dataSet: set)
        data.setDrawValues(true)
        
        lineChart.data = data
        lineChart.animate(xAxisDuration: 2)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        self.dateLabel.text = self.dataKeyValues[Int(entry.x)].key
        priceLabel.text = "\(entry.y)"
    }
}

// MARK: Buy / Sell Views
extension InstrumentDetailViewController {
    
    @IBAction func buyPressed(_ sender: Any) {
        slideupBuyView.stock = self.stock
        let screenSize = view.bounds.size
        slideupBuyView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: slideupViewHeight)
        
        view.addSubview(slideupBuyView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.slideupBuyView.frame = CGRect(x: 0, y: screenSize.height - self.slideupViewHeight, width: screenSize.width, height: self.slideupViewHeight)
            self.view.backgroundColor = .lightGray
        }, completion: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBuyView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func sellPressed(_ sender: Any) {
        slideupSellView = sellView()
        slideupSellView!.stock = self.stock
        slideupSellView!.setupView()
        let screenSize = view.bounds.size
        slideupSellView!.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: slideupViewHeight)
        
        view.addSubview(slideupSellView!)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.slideupSellView!.frame = CGRect(x: 0, y: screenSize.height - self.slideupViewHeight, width: screenSize.width, height: self.slideupViewHeight)
            self.view.backgroundColor = .lightGray
        }, completion: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSellView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissBuyView() {
        let screenSize = view.bounds.size
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.slideupBuyView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.slideupViewHeight)
            self.view.backgroundColor = .systemBackground
        }, completion: nil)
    }
    
    @objc func dismissSellView() {
        let screenSize = view.bounds.size
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.slideupSellView!.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.slideupViewHeight)
            self.view.backgroundColor = .systemBackground
        }, completion: nil)
    }
}

