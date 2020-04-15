//
//  Lab4ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 09.04.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class Lab4ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var aroundTheSeparatedPoints: UILabel!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var accuracyTextField: UITextField!
    @IBOutlet weak var xResultLabel: UILabel!
    @IBOutlet weak var yResultLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var viewToHide: UIView!
    @IBOutlet weak var viewToHide2: UIView!
    @IBOutlet weak var viewToHide3: UIView!
    @IBOutlet weak var xStackView: UIStackView!
    @IBOutlet weak var yStackView: UIStackView!
    @IBOutlet weak var showChartButton: UIButton!
    
    var intervals: [[Double]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromTextField.delegate = self
        toTextField.delegate = self
        accuracyTextField.delegate = self
        
        showChartButton.layer.cornerRadius = CGFloat((Double(showChartButton.frame.height) ) / 2.3)
        
        resultLabel.isHidden = true
        xStackView.isHidden = true
        yStackView.isHidden = true
        
        showIntervals()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        fromTextField.resignFirstResponder()
        toTextField.resignFirstResponder()
        accuracyTextField.resignFirstResponder()
        
        let pointA = Double(fromTextField.text ?? "0") ?? 0.0
        let pointB = Double(toTextField.text ?? "0") ?? 0.0
        let epsilon = Double(accuracyTextField.text ?? "0") ?? 0.0
        
        let (x, y) = halfSplitMethod(pointA: pointA, pointB: pointB, epsilon: epsilon)
        if (x != 0) && (y != 0) {
            xResultLabel.attributedText = x.scientificFormatted
            yResultLabel.attributedText = y.scientificFormatted
        } else {
            present(noticeAlert(message: "У цьому околі нулів функції немає або він не один!"), animated: true, completion: nil)
        }
        
        viewToHide.isHidden = true
        viewToHide2.isHidden = true
        viewToHide3.isHidden = true
        resultLabel.isHidden = false
        xStackView.isHidden = false
        yStackView.isHidden = false
        return true
    }
    
    
    /// Повертає значення функції в залежності від даного аргумента.
    func f (_ x: Double) -> Double{
        return pow(2, x) - 2 * pow(x, 2) - 1
    }
    
    
    /**
    Виконує відокремлення коренів рівняння, що дослиджується.
     Виводить проміжки у яких є нулі функції.
    */
    func showIntervals() {
        var intervalArr: [[Double]] = []
        var border = -10.0
        let step = 0.01

        while intervalArr.count != 3 {
            if (f(border) * f(border + step) < 0) || (f(border) == 0) {
                intervalArr.append([border.rounded(digits: 4), (border + step).rounded(digits: 4)])
            }
            border += step
        }
        aroundTheSeparatedPoints.text = "[\(intervalArr[0][0]), \(intervalArr[0][1])], [\(intervalArr[1][0]), \(intervalArr[1][1])], [\(intervalArr[2][0]), \(intervalArr[2][1])]"
        intervals = intervalArr
    }
    
    
    /**
    Реалізація методу половинного ділення
    - Parameters:
       - pointA: нижня границя проміжку
       - pointB: верхня границя проміжку
       - epsilon: точність
    - Returns: координати знайденої точки (x, y)
    */
    func halfSplitMethod(pointA: Double, pointB: Double, epsilon: Double) -> (Double, Double) {
        var a = pointA
        var b = pointB
        var c = 0.0

        if f(a) * f(b) > 0 {
            return (0, 0)
            
        } else if f(a) == 0 {
            return (a, f(a))
            
        } else if f(b) == 0 {
            return (b, f(b))
            
        } else {
            c = (a + b) / 2
            
            while !(abs(b - a) < epsilon || f(c) == 0) {
                
                if f(a) * f(c) < 0 {
                    b = c
                } else {
                    a = c
                }
                c = (a + b) / 2
                
            }
            return (c, f(c))
        }
    }
    
    
    func creatDataForChart() -> ([Double], [Double]) {
        var xArr: [Double] = []
        var yArr: [Double] = []
        for x in stride(from: -1, to: 7, by: 0.01) {
            xArr.append(x)
            yArr.append(f(x))
        }
        return (xArr, yArr)
    }
    
    
    /**
     Метод, що по черзі знаходить усі нулі ф-ї, яка досліджується.
       - Використовуються функція, що реалізує метод половинного ділення, та інтервали, що формуються врезультаті відокремлення коренів.
    */
    func findAllPoints() -> ([Double], [Double]) {
        var xArr: [Double] = []
        var yArr: [Double] = []
        for i in 0..<intervals.count {
            let (x, y) = halfSplitMethod(pointA: intervals[i][0], pointB: intervals[i][1], epsilon: 0.01)
            xArr.append(x)
            yArr.append(y)
        }
        print(xArr)
        print(yArr)
        return (xArr, yArr)
    }
    
    
    @IBAction func didPressShowChartButton(_ sender: UIButton) {
        let (lineX, lineY) = creatDataForChart()
        let (circleX, circleY) = findAllPoints()
        let values = dataForChart(arrayX: lineX, arrayY: lineY)
        let circleValues = dataForChart(arrayX: circleX, arrayY: circleY)
        
        guard let chartVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab4ChartViewController") as? Lab4ChartViewController else { return }
            
        DispatchQueue.main.async {
            
            chartVC.chartValues = values
            chartVC.circlesValues = circleValues

            self.navigationController?.pushViewController(chartVC, animated: true)
        }
    }
    
}

extension UIViewController {
     public func noticeAlert(message: String) -> UIAlertController {
         let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
         let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
         alert.addAction(okBtn)
         return alert
     }

}
