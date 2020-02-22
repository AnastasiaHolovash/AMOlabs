//
//  Lab1Task3ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 21.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class Lab1Task3ViewController: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var arrayLabel: UILabel!
    @IBOutlet weak var arrayALabel: UILabel!
    @IBOutlet weak var arrayBLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manually()
        
        resultButton.layer.cornerRadius = CGFloat((Double(resultButton.frame.height) ) / 2.0)

        // Hides the resultButton moving it down
               UIView.animate(withDuration: 0) {
               self.resultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
               }
               
               // Listen for keyboard events
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillChange(notification: Notification){
        
        if notification.name.rawValue == "UIKeyboardWillShowNotification"{
            UIView.animate(withDuration: 2) {
                self.resultButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
        }else{
            UIView.animate(withDuration: 2) {
                self.resultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
            }
        }
    }
    
    deinit {
        // Stop listening for keyboard show/hide events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func hideKeybourd() {
        firstTextField.resignFirstResponder()
        secondTextField.resignFirstResponder()
    }
     // MARK: Винести
    func prepareArray(textField: UITextField) -> [Double] {
        let splited = (textField.text ?? "").split(separator: ",")
        var arrayA: [Double] = []
        
        for one in splited {
            let trimmed = String(one).trimmingCharacters(in: .whitespacesAndNewlines)
            arrayA.append(Double(trimmed) ?? 0.0)
        }
        
        return arrayA
    }
    
    func showResultLab1Tack3(_ arrayA: [Double], _ arrayB: [Double]) {
        var result = 0.0
        
        for i in arrayA{
            var multiplication = 1.0
            for j in arrayB{
                multiplication *= pow(i, 2) + pow(j, 3)
            }
            result += multiplication
        }
        print(result)
        resultLabel.text = String(result)
        hideKeybourd()
    }
    
    
    @IBAction func didPressResult(_ sender: UIButton) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            
            let arrayA: [Double] = prepareArray(textField: firstTextField)
            let arrayB: [Double] = prepareArray(textField: secondTextField)
            
            showResultLab1Tack3(arrayA, arrayB)
            
        case 1:
            
            if firstTextField.text == "" || secondTextField.text == ""{
                resultLabel.text = ""
                hideKeybourd()
            
            } else {
                let n = Int((firstTextField.text ?? "").replacingOccurrences(of: ",", with: ".")) ?? 0
                let p = Int((secondTextField.text ?? "").replacingOccurrences(of: ",", with: ".")) ?? 0
                var arrayA: [Double] = []
                var arrayB: [Double] = []
                
                var stringArrayA: [Double] = []
                var stringArrayB: [Double] = []
                
                for _ in 1...n {
                    arrayA.append(Double.random(in: 1..<100))
                }
                for _ in 1...p {
                    arrayB.append(Double.random(in: 1..<100))
                }
                showResultLab1Tack3(arrayA, arrayB)
                
                for i in arrayA{
                    stringArrayA.append(i.rounded(digits: 3))
                }
                for j in arrayB{
                    stringArrayB.append(j.rounded(digits: 3))
                }
                
                arrayLabel.text = "Згенеровані масиви:"
                arrayALabel.text = "A: " + stringArrayA.description
                arrayBLabel.text = "B: " + stringArrayB.description
                
            }

        default:
            arrayLabel.text = nil
        }
    }
    
    func manually () {
        firstLabel.text = "A[] :"
        secondLabel.text = "B[] :"
        firstTextField.placeholder = "Введіть елементи масиву"
        secondTextField.placeholder = "Введіть елементи масиву"
        firstTextField.text = ""
        secondTextField.text = ""

    }
    
    @IBAction func didChangeSigment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            manually()
            
        case 1:
            firstLabel.text = "n :"
            secondLabel.text = "p :"
            firstTextField.placeholder = "Введіть число"
            secondTextField.placeholder = "Введіть число"
            firstTextField.text = ""
            secondTextField.text = ""
            
        default:
            firstLabel.text = " "
            secondLabel.text = " "
            firstTextField.placeholder = " "
            secondTextField.placeholder = " "
            firstTextField.text = ""
            secondTextField.text = ""
        }
    }
    

}

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
