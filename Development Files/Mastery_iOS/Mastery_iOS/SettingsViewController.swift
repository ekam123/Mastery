//
//  SettingsViewController.swift
//  Mastery_iOS
//
//  Created by Marina Mona June McPeak on 2019-07-30.
//  Copyright © 2019 Marina Mona June McPeak. All rights reserved.
//

import UIKit
import Charts

class SettingsViewController : UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var gradientColorView: UIView!
    @IBOutlet weak var graphView: LineChartView!
    
    var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueLabel = UILabel(frame: CGRect(x: 50, y: 10, width: 50, height: 20))
//        valueLabel.backgroundColor = UIColor.black
        valueLabel.textColor = UIColor.white
        valueLabel.isHidden = true
        gradientColorView.addSubview(valueLabel)
        
        graphView.delegate = self
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(gestureRecognizer(gesture:)))
        graphView.isUserInteractionEnabled = true
        graphView.addGestureRecognizer(gesture)
        createChart()
        produceGradients()
        
        //        graphView.lineData = lineChartData
        
    }
    
    func highlightValues(chartHighlight: ChartHighlighter){
        
    }
    
    func createChart() {
        let entry1 = ChartDataEntry(x: 1.0, y: Double(1))
        let entry2 = ChartDataEntry(x: 2.0, y: Double(8))
        let entry3 = ChartDataEntry(x: 3.0, y: Double(3))
        let entry4 = ChartDataEntry(x: 4.0, y: Double(4))
        let entry5 = ChartDataEntry(x: 5.0, y: Double(7))
        let entry6 = ChartDataEntry(x: 6.0, y: Double(2))
        let dataSet = LineChartDataSet(entries: [entry1, entry2, entry3, entry4, entry5, entry6], label: "")
        
        dataSet.valueTextColor = UIColor.white
        dataSet.highlightEnabled = true
        dataSet.setDrawHighlightIndicators(true)
        dataSet.highlightColor = UIColor.yellow
        let data = LineChartData(dataSets: [dataSet])
        
        //        dataSet.drawCircleHoleEnabled = true
        //        dataSet.circleRadius = 2
        graphView.data = data
        graphView.legend.enabled = false
        graphView.leftAxis.drawLabelsEnabled = false
        graphView.xAxis.drawLabelsEnabled = false
        graphView.rightAxis.drawLabelsEnabled = false
        //        graphView.leftAxis.enabled = false
        //        graphView.rightAxis.enabled = false
        //        graphView.xAxis.enabled = false
        
        
        
        //       graphView.chartDescription?.text = "Number of Widgets by Type"
        
        //All other additions to this function will go here
        
        //        graphView.
        //This must stay at end of function
        graphView.notifyDataSetChanged()
        
        
        //        let color = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        //        let colorTwo = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        //        let gradientColors = [color.cgColor, colorTwo.cgColor] as CFArray
        //        let colorLocations:[CGFloat] = [0.0, 1.0]
        //        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        //        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        //        dataSet.drawFilledEnabled = true
    }
    
    
    func produceGradients() {
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        //        gradientLayer.colors = [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).cgColor,#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor ]
        gradientLayer.colors = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1).cgColor,#colorLiteral(red: 0.8906239867, green: 0.5771891557, blue: 0.4392894992, alpha: 1).cgColor ]
        
        //        gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 1, 2, 2, 0)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = gradientColorView.bounds
        //        gradientColorView.backgroundColor = UIColor.clear
        gradientColorView.layer.insertSublayer(gradientLayer, at: 0)
        
        //        let gradientLayerTwo: CAGradientLayer = CAGradientLayer()
        //        let color = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        //        let colorTwo = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        //        gradientLayerTwo.colors = [color.cgColor, colorTwo.cgColor]
        //        gradientLayerTwo.locations = [0.0, 1.0]
        //        gradientLayerTwo.startPoint = CGPoint(x: 0.0, y: 0.0)
        //        gradientLayerTwo.endPoint = CGPoint(x: 1.0, y: 1.0)
        //        gradientLayerTwo.frame = graphView.bounds
        //        graphView.layer.insertSublayer(gradientLayerTwo, at: 0)
    }
    
    
    @objc func gestureRecognizer(gesture: UILongPressGestureRecognizer) {
        
        let point = gesture.location(in: graphView)
        let highlight = graphView.getHighlightByTouchPoint(point)
        graphView.highlightValue(highlight)
        //    print(graphView.chart)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
        let graphPoint = highlight.xPx
        print(graphPoint)
        valueLabel.text = "\(entry.y)"
        valueLabel.center = CGPoint(x: graphPoint, y: valueLabel.center.y)
        valueLabel.isHidden = false
    }
    
    @IBAction func cancelDownload(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    
}
