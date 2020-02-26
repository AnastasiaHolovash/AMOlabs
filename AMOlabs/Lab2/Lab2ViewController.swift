//
//  Lab2ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 22.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class Lab2ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textFied: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var enteredTextView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!
//    @IBOutlet weak var resultButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manually()
        
//        resultButton.layer.cornerRadius = CGFloat((Double(resultButton.frame.height) ) / 2.0)
//
//         // Hides the resultButton moving it down
//                UIView.animate(withDuration: 0) {
//                self.resultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
//                }
                
//                // Listen for keyboard events
//                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let array: [Double] = prepareArray(textField: textFied)
            showResult(array)
            
        case 1:
            if textFied.text == "" {
                resultTextView.text = ""
                hideKeybourd()
            } else {
                let array: [Double] = createArray(textFied)
                showResult(array)
            }

        default:
            enteredTextView.text = nil
            resultTextView.text = nil
            timeLabel.text = nil
        }
        return true
    }
    
//    @objc func keyboardWillChange(notification: Notification){
//
//        if notification.name.rawValue == "UIKeyboardWillShowNotification"{
//            UIView.animate(withDuration: 2) {
//                self.resultButton.transform = CGAffineTransform(translationX: 0, y: 0)
//            }
//        } else {
//            UIView.animate(withDuration: 2) {
//                self.resultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
//            }
//        }
//    }
//
//    deinit {
//        // Stop listening for keyboard show/hide events
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
    
    func alert() -> UIAlertController {
        let alert = UIAlertController(title: "", message: "Введіть ціле число більше за 0", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okBtn)
        return alert
    }
    
    func hideKeybourd() {
        textFied.resignFirstResponder()
    }
 
    func showResult(_ array: [Double]) {
//        var stringArray: [Double] = []
//        var stringSortArray: [Double] = []
        var sortArray = array
        let start = Date()
        quicksortHoare(&sortArray, low: 0, high: sortArray.count - 1)
        let end = Date()
//        for i in array{
//            stringArray.append(i.rounded(digits: 3))
//        }
//        for j in sortArray{
//            stringSortArray.append(j.rounded(digits: 3))
//        }
        
        let timeInterval: Double = end.timeIntervalSince(start)
        timeLabel.text = "\(array.count) елементів.  Час: \(timeInterval.rounded(digits: 8))"
        enteredTextView.text = "Початковий масив: " + array.description
        resultTextView.text = "Відсортований масив: " + sortArray.description
        
        hideKeybourd()
    }
    
    func createArray(_ textFied: UITextField) -> [Double] {
        let n = Int((textFied.text ?? "").replacingOccurrences(of: ",", with: ".")) ?? 0
        var array: [Double] = []
        if n == 0 {
            present(alert(), animated: true, completion: nil)
        } else {
            for _ in 1...n {
                array.append(Double.random(in: 1..<100).rounded(digits: 3))
            }
        }
        return array
    }
    
    
//    @IBAction func didPressResult(_ sender: UIButton) {
//        switch segmentControl.selectedSegmentIndex {
//        case 0:
//            let array: [Double] = prepareArray(textField: textFied)
//            showResult(array)
//
//        case 1:
//            if textFied.text == "" {
//                resultTextView.text = ""
//                hideKeybourd()
//            } else {
//                let array: [Double] = createArray(textFied)
//                showResult(array)
//            }
//
//        default:
//            resultTextView.text = nil
//        }
//    }
    
    
    func manually () {
        textFied.placeholder = "Введіть масив"
        cleanText()
    }
    
    
    func cleanText() {
        textFied.text = ""
        enteredTextView.text = ""
        resultTextView.text = ""
        timeLabel.text = ""
    }
    
    
    @IBAction func didChangeSigment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            manually()
        case 1:
            textFied.placeholder = "Введіть кількість елементів"
            cleanText()
        default:
            textFied.placeholder = ""
            cleanText()
        }
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
    
    func partitionHoare(_ a: inout [Double], low: Int, high: Int) -> Int {
        let pivot = a[low]
        var i = low - 1
        var j = high + 1
        
        while true {
            repeat { j -= 1 } while a[j] > pivot
            repeat { i += 1 } while a[i] < pivot
            
            if i < j {
                a.swapAt(i, j)
            } else {
                return j
            }
        }
    }

    func quicksortHoare(_ a: inout [Double], low: Int, high: Int) {
        if low < high {
            let p = partitionHoare(&a, low: low, high: high)
            quicksortHoare(&a, low: low, high: p)
            quicksortHoare(&a, low: p + 1, high: high)
        }
    }
}
