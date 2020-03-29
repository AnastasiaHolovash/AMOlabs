//
//  Lab3Functions.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 29.03.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit
import Charts

func valueOfTheGivenFunction(_ accuracy : Int, segmentControl:UISegmentedControl, a: Double = 0.0, b: Double = 5.0) -> (x: [Double], y: [Double]){
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
        }
    default:
        x = []
        y = []
    }
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

func opositArray(x: [Double]) -> [Double] {
    var newX: [Double] = []
    for element in x.reversed() {
        newX.append(element)
    }
    return newX
}

func differenceModuleChack2 (array: [Double], n: Int) -> Double {
    var dif = [array.max() ?? 0.0]
    var index = 0
    
    for i in 0..<(array.count - n) {
        if i != 0 && i != 1 {
            dif.append(abs(array[i] - array[i - 1]))
            if dif[i - 1] >= dif[i - 2] { break }
            index = i
        }
    }
    return array[index]
}


func blurError(_ estimationOfInterpolationErrorEstimation: [Double], _ estimationOfInterpolationError: [Double]) -> [Double] {
    var result: [Double] = []
    for i in 0..<estimationOfInterpolationErrorEstimation.count {
        result.append(estimationOfInterpolationErrorEstimation[i] / estimationOfInterpolationError[i])
    }
    return result
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


