//
//  Lab3ChartViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 27.03.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit
import Charts

class Lab3ChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView2: LineChartView!
    @IBOutlet weak var chartView: LineChartView!
    var valuesSegue: [ChartDataEntry]?
    var valuesSegue2: [ChartDataEntry]?
    var valuesSegueMistake: [ChartDataEntry]?
    var nSegue: Int?
    var funcsion: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if funcsion {
            self.title = "Графік e^(sin(x))"
        } else {
            self.title = "Графік sin(x)"
        }
        
        setupChartView()
        setupChartView2()
        
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

//        if funcsion {
//            /// Maximum of y
//            leftAxis.axisMaximum = 3.5
//
//            /// Minimum of y
//            leftAxis.axisMinimum = -0.5
//        } else {
//            /// Maximum of y
//            leftAxis.axisMaximum = 1.1
//
//            /// Minimum of y
//            leftAxis.axisMinimum = -1.1
//        }
        
        
        leftAxis.gridLineDashLengths = [3, 1]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        
        chartView.animate(xAxisDuration: 2.5)
    }
    
    private func setupChartView2() {
        chartView2.delegate = self
        
        chartView2.chartDescription?.enabled = false
        chartView2.dragEnabled = true
        chartView2.setScaleEnabled(true)
        chartView2.pinchZoomEnabled = true
        
        chartView2.xAxis.gridLineDashLengths = [3, 1]
        chartView2.xAxis.gridLineDashPhase = 0
        
        let leftAxis = chartView2.leftAxis
        leftAxis.removeAllLimitLines()
        
//        if funcsion {
//            /// Maximum of y
//            leftAxis.axisMaximum = 0.035
//            
//            /// Minimum of y
//            leftAxis.axisMinimum = -0.025
//        } else {
//            /// Maximum of y
//            leftAxis.axisMaximum = 0.000005
//            
//            /// Minimum of y
//            leftAxis.axisMinimum = -0.000005
//        }
        
        
        leftAxis.gridLineDashLengths = [3, 1]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView2.rightAxis.enabled = false
        
        chartView2.legend.form = .line
        
        chartView2.animate(xAxisDuration: 2.5)
    }
    

    
    
    func setDataCount(n: Int) {
        
        // Getting test values
        guard let valuesTest = valuesSegue else { return }
        guard let valuesTeor = valuesSegue2 else { return }
        guard let valuesMistake = valuesSegueMistake else { return }
        
        // First line (teoretical)
        let set1 = LineChartDataSet(entries: valuesTeor, label: "Інтерполяція")
        set1.drawIconsEnabled = false
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 0
        set1.drawCircleHoleEnabled = false
        set1.mode = .cubicBezier

        // Second line (test)
        let set2 = LineChartDataSet(entries: valuesTest, label: "Функція")
        set2.drawIconsEnabled = false
        set2.setColor(.blue)
        set2.setCircleColor(.blue)
        set2.lineWidth = 1
        set2.circleRadius = 0
        set2.drawCircleHoleEnabled = false
        set2.formSize = 15
        set2.mode = .cubicBezier
        
        
        let set3 = LineChartDataSet(entries: valuesMistake, label: "Похибка")
        set3.drawIconsEnabled = false
        set3.setColor(.red)
        set3.setCircleColor(.red)
        set3.lineWidth = 1
        set3.circleRadius = 0
        set3.drawCircleHoleEnabled = false
        set3.formSize = 15
        set3.mode = .cubicBezier

        
        // Setting this lines to data
        let data = LineChartData(dataSets: [set1, set2])
        chartView.data = data
        
        let data2 = LineChartData(dataSets: [set3])
        chartView2.data = data2
    }

}
