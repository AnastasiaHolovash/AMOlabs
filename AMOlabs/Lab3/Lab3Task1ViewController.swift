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
        
        tableButton.layer.cornerRadius = CGFloat((Double(tableButton.frame.height) ) / 2.5)
        chartButton.layer.cornerRadius = CGFloat((Double(chartButton.frame.height) ) / 2.5)

    }
    
    
    
    func valueOfTheGivenFunction(_ accuracy : Int) -> (x: [Double], y: [Double]){
        let h: Double = Double((b - a) / Double(accuracy))
        /// Масив значень іксів
        var x: [Double] = []
        /// Масив значень ігриків
        var y: [Double] = []
        switch segmentControl.selectedSegmentIndex {
        case 0:
            for i in 0...accuracy {
                x.append(Double(a) + h * Double(i))
                y.append(exp(sin(x[i])))
            }
        case 1:
            for i in 0...accuracy {
                x.append(Double(a) + h * Double(i))
                y.append(sin(x[i]))
    //          y.append(1.0 / (0.5 + pow(x[i], 2)))
            }
        default:
            x = []
            y = []
        }
//        print(x)
//        print(y)
        return (x, y)
    }

    func aitken(x: [Double], y: [Double], x0: Double) -> Double {
        let n = x.count
        var p: [Double] = []
        for _ in 0..<n {
            p.append(contentsOf: [0])
        }
        
        for k in 0..<n {
            let some = n - k
            for i in 0..<some {
                if k == 0 {
                    p[i] = y[i]
                } else {
                    p[i] = ((x0-x[i+k])*p[i]+(x[i]-x0)*p[i+1])/(x[i]-x[i+k])
                }
            }
        }
        return p[0]
    }
    
    //MARK: -lagrang
    func lagrang(arrayX: [Double], arrayY: [Double], t: Double) -> Double {
        var z: Double = 0
        
        for j in 0..<arrayY.count {
            var p1: Double = 1
            var p2: Double = 1
            
            for i in 0..<arrayX.count {
                if i != j {
                    p1 = p1 * (t - arrayX[i])
                    p2 = p2 * (arrayX[j] - arrayX[i])
                }
            }
            z = z + (arrayY[j] * (p1 / p2))
        }
            
        return z
    }
    
//    func aitken2(x: [Double], y: [Double], x0: Double) -> Double{
//
//        let n = x.count
//        var p = Array(repeating: Array(repeating: 0.0, count: n), count: n)
//        var j = 0
//        for k in 0...n {
//            for i in 0..<n-k {
//                if k == 0 {
//                    p[i][j] = y[i]
//                } else {
//                    let part11 = (x0 - x[i+k]) * p[i][j-1]
//                    let part12 = (x[i] - x0) * p[i+1][j-1]
//                    let part2 = (x[i] - x[i+k])
//                    p[i][j] = (part11 + part12) / part2
//                }
//            }
//            j += 1
//        }
//        let newX = opositArray(x: x)
//        let theNearest = newX.nearestOffsetAndElement(to: x0)
//        let index = p.count - theNearest.offset - 1
//
//        return differenceModuleChack2(array: p[index], n: index)
//    }
    
    
    func opositArray(x: [Double]) -> [Double] {
        var newX: [Double] = []
        for element in x.reversed() {
            newX.append(element)
        }
        return newX
    }
    
    
    func differenceModuleChack2 (array: [Double], n: Int) -> Double {
//      var test: [Double] = []
        var dif = [array.max() ?? 0.0]
        var index = 0
        
        for i in 0..<(array.count - n) {
            if i != 0 && i != 1 {
                dif.append(abs(array[i] - array[i - 1]))
    //            test.append(abs(array[i] - array[i - 1]))
    //            print(test)
                if dif[i - 1] >= dif[i - 2] { break }
                index = i
            }
        }
        return array[index]
    }
    
    func difference(_ first: [Double], _ second: [Double]) -> [Double] {
        var result: [Double] = []
        for i in 0..<first.count {
            result.append(first[i] - second[i])
        }
        return result
    }
    
    func dataForChart(arrayX: [Double], arrayY: [Double]) -> [ChartDataEntry] {
        var values: [ChartDataEntry] = []
        for i in 0..<arrayX.count {
            let charData = ChartDataEntry(x: arrayX[i], y: arrayY[i])
            values.append(charData)
        }
        return values
    }
    
    func interpolationArray(chartValuesX: [Double], count: Int) -> [Double] {
        let formulaValuesXY = valueOfTheGivenFunction(count)
        var result: [Double] = []
        for i in chartValuesX {
            result.append(aitken(x: formulaValuesXY.x, y: formulaValuesXY.y, x0: i))
//            result.append(lagrang(arrayX: formulaValuesXY.x, arrayY: formulaValuesXY.y, t: i))
        }
        return result
    }
    func blurError(_ estimationOfInterpolationErrorEstimation: [Double], _ estimationOfInterpolationError: [Double]) -> [Double] {
        var result: [Double] = []
        for i in 0..<estimationOfInterpolationErrorEstimation.count {
            result.append(estimationOfInterpolationErrorEstimation[i] / estimationOfInterpolationError[i])
        }
        return result
    }
    @IBAction func didChangeSegmentControl(_ sender: UISegmentedControl) {
        
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
            let (valuesX, valuesY) = valueOfTheGivenFunction(n)
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
        
        let chartValuesXY = valueOfTheGivenFunction(1000)

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

extension Sequence where Iterator.Element: SignedNumeric & Comparable {

    /// Finds the nearest (offset, element) to the specified element.
    func nearestOffsetAndElement(to toElement: Iterator.Element) -> (offset: Int, element: Iterator.Element) {

        guard let nearest = enumerated().min( by: {
            let left = $0.1 - toElement
            let right = $1.1 - toElement
            return abs(left) <= abs(right)
        } ) else {
            return (offset: 0, element: toElement)
        }

        return nearest
    }
}
