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
//        let y = halfSplitMethod(pointA: pointA, pointB: pointB, epsilon: epsilon)
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
    
    func findY (_ x: Double) -> Double{
        return pow(2, x) - 2 * pow(x, 2) - 1
    }
    
    func showIntervals() {
        var intervalArr: [[Double]] = []
        var border = -10.0
        let step = 0.01

        while intervalArr.count != 3 {
            if (findY(border) * findY(border + step) < 0) || (findY(border) == 0) {
                intervalArr.append([border.rounded(digits: 4), (border + step).rounded(digits: 4)])
            }
            border += step
        }
        aroundTheSeparatedPoints.text = "[\(intervalArr[0][0]), \(intervalArr[0][1])], [\(intervalArr[1][0]), \(intervalArr[1][1])], [\(intervalArr[2][0]), \(intervalArr[2][1])]"
    }
    
    func halfSplitMethod(pointA: Double, pointB: Double, epsilon: Double) -> (Double, Double) {
        var a = pointA
        var b = pointB
        var c = 0.0

        if findY(a) * findY(b) > 0 {
//            print("Нема розв'язку!")
            return (0, 0)
        } else if findY(a) == 0 {
//            print("x = \(a)")
//            print("y = \(findY(a))")
            return (a, findY(a))
        } else if findY(b) == 0 {
//            print("x = \(b)")
//            print("y = \(findY(b))")
            return (b, findY(b))
        } else {
            c = (a + b) / 2
            
            while !(abs(b - a) < epsilon || findY(c) == 0) {
                
                if findY(a) * findY(c) < 0 {
                    b = c
                } else {
                    a = c
                }
                c = (a + b) / 2
                
//                print("[\(a), \(b)]")
//                print(c)
            }
            
//            print("x = \(c)")
//            print("y = \(findY(c))")
            return (c, findY(c))
        }
    }
    
    @IBAction func didPressShowChartButton(_ sender: UIButton) {
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
