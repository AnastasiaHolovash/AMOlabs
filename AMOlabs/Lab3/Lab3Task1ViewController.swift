//
//  Lab3Task1ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 25.03.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit
import Charts

class Lab3Task1ViewController: UIViewController {

    @IBOutlet weak var interpolationDegreeTextField: UITextField!
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableButton: UIButton!
    @IBOutlet weak var chartButton: UIButton!
    
    
    let a = 0.0
    let b = 5.0
    var degreeOfInterpolation = 10
    var x = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableButton.layer.cornerRadius = CGFloat((Double(tableButton.frame.height) ) / 2.6)
        chartButton.layer.cornerRadius = CGFloat((Double(chartButton.frame.height) ) / 2.5)

    }
    
    
    func interpolationArray(chartValuesX: [Double], count: Int) -> [Double] {
        let formulaValuesXY = valueOfTheGivenFunction(count, segmentControl: segmentControl)
        var result: [Double] = []
        for i in chartValuesX {
            result.append(aitken(x: formulaValuesXY.x, y: formulaValuesXY.y, x0: i))
        }
        return result
    }


    func findYFromFunc(_ x: Double) -> Double {
        var y: Double = 0.0
        switch segmentControl.selectedSegmentIndex {
            case 0:
                y = exp(sin(x))
            case 1:
                y = sin(x)
            default:
                y = 0.0
        }
        return y
    }
    
    
    func dataForTable(maxDegreeOfInterpolation: Int, x: Double) -> (interpolasionErrorArray: [Double], differenceArray: [Double], interpolasionKArray: [Double]) {
        var interpolasionArrayForX: [Double] = []
        var differenceArray: [Double] = []
        let yExactValue = findYFromFunc(x)
        var interpolasionErrorArray: [Double] = []
        var interpolasionKArray: [Double] = []
        
        for n in 1...maxDegreeOfInterpolation + 1 {
            let (valuesX, valuesY) = valueOfTheGivenFunction(n, segmentControl: segmentControl)
//            let interpolasionValueForX = aitken(x: valuesX, y: valuesY, x0: x)
            
            interpolasionArrayForX.append(aitken(x: valuesX, y: valuesY, x0: x))
            differenceArray.append(interpolasionArrayForX[n - 1] - yExactValue)
            
            if n > 1 {
                interpolasionErrorArray.append(interpolasionArrayForX[n - 2] - interpolasionArrayForX[n - 1])
                interpolasionKArray.append(1 - differenceArray[n - 2] / interpolasionErrorArray[n - 2])
            }
        }
        return (interpolasionErrorArray, differenceArray, interpolasionKArray)
    }
    
    @IBAction func didPressShowTable(_ sender: UIButton) {
        degreeOfInterpolation = Int(interpolationDegreeTextField.text ?? "10") ?? 10
        guard let x = Double(xTextField.text ?? "0.5") else { return }
        
        let (interpolasionErrorArray, differenceArray, interpolasionKArray) = dataForTable(maxDegreeOfInterpolation: degreeOfInterpolation, x: x)
        var numbers: [Int] = []
        for i in 1...degreeOfInterpolation {
            numbers.append(i)
        }
        
        guard let tableVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ErrorTableViewViewController") as? ErrorTableViewViewController else { return }
                    
                DispatchQueue.main.async {
                    
                    tableVC.numbers = numbers
                    tableVC.interpolationError = interpolasionErrorArray
                    tableVC.interpolatedAndExactDifference = differenceArray
                    tableVC.refinementCoefficient = interpolasionKArray
                    tableVC.x = x

                    self.navigationController?.pushViewController(tableVC, animated: true)
                }
        
    }
    
    @IBAction func didPressShowChart(_ sender: UIButton) {
        degreeOfInterpolation = Int(interpolationDegreeTextField.text ?? "10") ?? 10
        
        let chartValuesXY = valueOfTheGivenFunction(1000, segmentControl: segmentControl)

        let interpolationYArray = interpolationArray(chartValuesX: chartValuesXY.x, count: degreeOfInterpolation)
        let interpolationErrorYArray = interpolationArray(chartValuesX: chartValuesXY.x, count: degreeOfInterpolation + 1)
        let interpolationErrorErrorYArray = interpolationArray(chartValuesX: chartValuesXY.x, count: degreeOfInterpolation + 2)

        let estimationOfInterpolationError = difference(interpolationYArray, interpolationErrorYArray)
        let estimationOfInterpolationErrorEstimation = difference(interpolationErrorYArray, interpolationErrorErrorYArray)
        let blurErrorArray = blurError(estimationOfInterpolationErrorEstimation, estimationOfInterpolationError)
        
        let values = dataForChart(arrayX: chartValuesXY.x, arrayY: chartValuesXY.y)
        let values2 = dataForChart(arrayX: chartValuesXY.x, arrayY: interpolationYArray)
        let valuesMistake = dataForChart(arrayX: chartValuesXY.x, arrayY: estimationOfInterpolationError)
        
        var mathFunc: Bool = true
        switch segmentControl.selectedSegmentIndex {
        case 0:
            mathFunc = true
        case 1:
            mathFunc = false
        default:
            mathFunc = true
        }
    
        
        guard let chartVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab3ChartViewController") as? Lab3ChartViewController else { return }
                
            DispatchQueue.main.async {
                
                chartVC.valuesSegue = values
                chartVC.valuesSegue2 = values2
                chartVC.valuesSegueMistake = valuesMistake
                chartVC.funcsion = mathFunc
    //            chartVC.nSegue = self.sliderValue

                self.navigationController?.pushViewController(chartVC, animated: true)
            }
        
    }
}


