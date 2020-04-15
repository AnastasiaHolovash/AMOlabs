//
//  Lab4ChartViewController.swift
//  
//
//  Created by Головаш Анастасия on 10.04.2020.
//

import UIKit
import Charts

class Lab4ChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: LineChartView!
    
    var chartValues: [ChartDataEntry]?
    var circlesValues: [ChartDataEntry]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "f(x) = 2^x-2x^2-1"
        setupChartView()
        
        /// Number of for loops for theoretical value
        self.setDataCount(n: 70)

    }
    
    private func setupChartView() {
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        chartView.xAxis.gridLineDashLengths = [3, 1]
        chartView.xAxis.gridLineDashPhase = 0
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        
        leftAxis.gridLineDashLengths = [3, 1]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        chartView.legend.font = NSUIFont(name: "Helvetica", size: 15) ?? NSUIFont()
        
        chartView.animate(xAxisDuration: 2.5)
    }

    func setDataCount(n: Int) {
        
        guard let values = chartValues else { return }
        
        let set1 = LineChartDataSet(entries: values, label: "f(x)")
        set1.drawIconsEnabled = false
        set1.drawValuesEnabled = false
        set1.setColor(.red)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 0
        set1.drawCircleHoleEnabled = false
        set1.mode = .cubicBezier

        guard let circles = circlesValues else { return }
        
        let circle = LineChartDataSet(entries: circles, label: "Нулі функції")
            
        circle.setCircleColor(.black)
        circle.setColor(.black)
        circle.lineWidth = 0
    
        circle.circleRadius = 3
        circle.drawCirclesEnabled = true
        circle.drawValuesEnabled = false
        
        // Setting this lines to data
        let data = LineChartData(dataSets: [set1, circle])
        chartView.data = data
        
    }
}
