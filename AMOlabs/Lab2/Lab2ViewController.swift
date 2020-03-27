//
//  Lab2ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 22.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit
import Charts

class Lab2ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textFied: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var enteredTextView: UITextView!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var rangeSlider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var sliderStackView: UIStackView!
    //    @IBOutlet weak var resultButton: UIButton!
    
    var sliderValue = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manually()
        rangeSlider.minimumValue = 1
        rangeSlider.maximumValue = 1000
        rangeSlider.value = 100
        sliderLabel.text = "100"
        sliderStackView.isHidden = true
        
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
        var sortArray = array
        let start = Date()
        quicksortHoare(&sortArray, low: 0, high: sortArray.count - 1)
        let end = Date()
        
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
//            let max = sliderValue
//            let range = Range(0...max)
//            let cRange = ClosedRange(range)
            for _ in 1...n {
                array.append(Double.random(min: 0.00, max: Double(sliderValue)).rounded(digits: 3))
//                array.append(Double.random(in: range).rounded(digits: 3))
            }
        }
        return array
    }
    
    
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
            sliderStackView.isHidden = true
        case 1:
            textFied.placeholder = "Введіть кількість елементів"
            cleanText()
            sliderStackView.isHidden = false

        default:
            textFied.placeholder = ""
            cleanText()
            sliderStackView.isHidden = false

        }
    }
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        sliderLabel.text = "\(sliderValue)"
    }
    
    /// Get test results withot any funcions
    /// - Parameters:
    ///     - count: Number of for loops for test value in witch array length = count * 1000
    func getTestValues(count: Int) -> [ChartDataEntry] {
        var values: [ChartDataEntry] = []
        
        for n in 1..<count {
            let nn = n * 1000
            
            var arrayA: [Double] = []

            for _ in 0..<nn {
                arrayA.append((Double.random(in: 0..<500).rounded(digits: 2)))
            }
            let start = Date()
            quicksortHoare(&arrayA, low: 0, high: arrayA.count - 1)
            let end = Date()
            
            let timeInterval: Double = end.timeIntervalSince(start)
                    
            let charData = ChartDataEntry(x: Double(nn), y: timeInterval * 1000)

            values.append(charData)
        }
        return values
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
