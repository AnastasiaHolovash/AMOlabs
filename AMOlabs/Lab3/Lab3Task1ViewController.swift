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

    let a = 0.0
    let b = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueOfTheGivenFunction(10)
        let x = [-1.0, 0.0, 2.0, 4.0,  6.0, 9.0]
        let y = [-2.0, 3.0, 1.0, 7.0, -1.0, 5.0]
//        aitken(x: x, y: y, x0: -0.5)
        var interYArray: [Double] = []
        for i in valueOfTheGivenFunction(10).x {
            interYArray.append(aitken2(x: valueOfTheGivenFunction(10).x, y: valueOfTheGivenFunction(10).y, x0: i + 0.5))
        }
//         aitken2(x: x, y: y, x0: -0.5)
        print("DIFERENS")
        for i in 0..<valueOfTheGivenFunction(10).y.count {
            print(valueOfTheGivenFunction(10).y[i] - interYArray[i])
        }
    }
    
    
    
    func valueOfTheGivenFunction(_ accuracy : Int) -> (x: [Double], y: [Double]){
        let h: Double = Double((b - a) / Double(accuracy))
        /// Масив значень іксів
        var x: [Double] = []
        /// Масив значень ігриків
        var y: [Double] = []
        for i in 0..<accuracy {
            x.append(Double(a) + h * Double(i))
            y.append(exp(sin(x[i])))
//            y.append(1.0 / (0.5 + pow(x[i], 2)))
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
    
    func aitken2(x: [Double], y: [Double], x0: Double) -> Double{
        
        let n = x.count
        var p = Array(repeating: Array(repeating: 0.0, count: n), count: n)
        var j = 0
        for k in 0...n {
            for i in 0..<n-k {
                if k == 0 {
                    p[i][j] = y[i]
                } else {
                    let part11 = (x0 - x[i+k]) * p[i][j-1]
                    let part12 = (x[i] - x0) * p[i+1][j-1]
                    let part2 = (x[i] - x[i+k])
                    p[i][j] = (part11 + part12) / part2
                }
            }
            j += 1
        }
//        print("P: \(p)")
//        print("RESULT: \(p[0])")
        let newX = opositArray(x: x)
//        print(newX)
        let theNearest = newX.nearestOffsetAndElement(to: x0)
//        print(theNearest)
        let index = p.count - theNearest.offset - 1
//        p[index][4] = 2.375
//        p[index][5] = 3.375
//        print(differenceModuleChack(array: p[index], n: index))
//        print(differenceModuleChack2(array: p[index], n: index))
        
        return differenceModuleChack2(array: p[index], n: index)
    }
    
    
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
    
    @IBAction func didPressShowChart(_ sender: UIButton) {
        
        let formulaValuesXY = valueOfTheGivenFunction(10)
        let chartValuesXY = valueOfTheGivenFunction(1000)
//        let arrayX = valuesXY.x
//        let arrayY = valuesXY.y
        var interYArray: [Double] = []
        for i in chartValuesXY.x {
            interYArray.append(aitken2(x: formulaValuesXY.x, y:formulaValuesXY.y, x0: i))
        }
        let differenceY = difference(chartValuesXY.y, interYArray)
        
        let values = dataForChart(arrayX: chartValuesXY.x, arrayY: chartValuesXY.y)
        let values2 = dataForChart(arrayX: chartValuesXY.x, arrayY: interYArray)
        let valuesMistake = dataForChart(arrayX: chartValuesXY.x, arrayY: differenceY)
        
//        for i in 0..<valuesX.x.count {
//            let charData = ChartDataEntry(x: valuesX.x[i], y: valuesX.y[i])
//            values.append(charData)
//        }
//
//        for i in 0..<valuesX.x.count {
//            let charData = ChartDataEntry(x: valuesX.x[i], y: interYArray[i])
//            values2.append(charData)
//        }
        
        

        guard let chartVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab3ChartViewController") as? Lab3ChartViewController else { return }
                
            DispatchQueue.main.async {
                
                chartVC.valuesSegue = values
                chartVC.valuesSegue2 = values2
                chartVC.valuesSegueMistake = valuesMistake
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
