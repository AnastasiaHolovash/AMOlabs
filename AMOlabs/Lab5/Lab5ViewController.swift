//
//  ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 14.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class Lab5ViewController: UIViewController {

    @IBOutlet weak var x11: UITextField!
    @IBOutlet weak var x12: UITextField!
    @IBOutlet weak var x13: UITextField!
    @IBOutlet weak var x14: UITextField!
    
    @IBOutlet weak var x21: UITextField!
    @IBOutlet weak var x22: UITextField!
    @IBOutlet weak var x23: UITextField!
    @IBOutlet weak var x24: UITextField!
    
    @IBOutlet weak var x31: UITextField!
    @IBOutlet weak var x32: UITextField!
    @IBOutlet weak var x33: UITextField!
    @IBOutlet weak var x34: UITextField!
    
    @IBOutlet weak var x41: UITextField!
    @IBOutlet weak var x42: UITextField!
    @IBOutlet weak var x43: UITextField!
    @IBOutlet weak var x44: UITextField!
    
    @IBOutlet weak var b1: UITextField!
    @IBOutlet weak var b2: UITextField!
    @IBOutlet weak var b3: UITextField!
    @IBOutlet weak var b4: UITextField!
    
    @IBOutlet weak var x12Label: UILabel!
    @IBOutlet weak var x13Label: UILabel!
    @IBOutlet weak var x22Label: UILabel!
    @IBOutlet weak var x23Label: UILabel!
    @IBOutlet weak var x33Label: UILabel!
    
    
    /// for hiding
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var stackView4: UIStackView!
    @IBOutlet weak var view13: UIView!
    @IBOutlet weak var view14: UIView!
    @IBOutlet weak var view23: UIView!
    @IBOutlet weak var view24: UIView!
    @IBOutlet weak var view34: UIView!

    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var steper: UIStepper!
    @IBOutlet weak var epsilon: UITextField!
    
    var stepperValue = 3
    var enteredDataArray: [[Double]] = []
    var epsilonValue = 0.01
    var resultString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateButton.layer.cornerRadius = CGFloat((Double(calculateButton.frame.height) ) / 3.5)
        redView.layer.cornerRadius = CGFloat((Double(redView.frame.height) ) / 20)
        
        stackView4.isHidden = true
        view14.isHidden = true
        view24.isHidden = true
        view34.isHidden = true
        x13Label.text = "x3="
        x23Label.text = "x3="
        x33Label.text = "x3="
        setMyVariant()
                    
    }
    
    func makeAnArray(sise: Int) {
        enteredDataArray = []
        var enteredDataString: [String] = []
        enteredDataArray.append([x11.doubleValue(), x12.doubleValue()])
        enteredDataArray.append([x21.doubleValue(), x22.doubleValue()])
        
        enteredDataString.append("Початкова система:")
        enteredDataString.append("\(x11.text ?? "0.0")x1 + \(x12.text ?? "0.0")x2")
        enteredDataString.append("\(x21.text ?? "0.0")x1 + \(x22.text ?? "0.0")x2")
        
        if sise > 2 {
            enteredDataArray[0].append(x13.doubleValue())
            enteredDataArray[1].append(x23.doubleValue())
            enteredDataArray.append([x31.doubleValue(), x32.doubleValue(), x33.doubleValue()])
            
            enteredDataString[1].append(contentsOf: " + \(x13.text ?? "0.0")x3")
            enteredDataString[2].append(contentsOf: " + \(x23.text ?? "0.0")x3")
            enteredDataString.append("\(x31.text ?? "0.0")x1 + \(x32.text ?? "0.0")x2 + \(x33.text ?? "0.0")x3")
        }
        if sise > 3 {
            enteredDataArray[0].append(x14.doubleValue())
            enteredDataArray[1].append(x24.doubleValue())
            enteredDataArray[2].append(x34.doubleValue())
            enteredDataArray.append([x41.doubleValue(), x42.doubleValue(), x43.doubleValue(), x44.doubleValue()])
            
            enteredDataString[1].append(contentsOf: " + \(x14.text ?? "0.0")x4")
            enteredDataString[2].append(contentsOf: " + \(x24.text ?? "0.0")x4")
            enteredDataString[3].append(contentsOf: " + \(x34.text ?? "0.0")x4")
            enteredDataString.append("\(x41.text ?? "0.0")x1 + \(x42.text ?? "0.0")x2 + \(x43.text ?? "0.0")x3 + \(x44.text ?? "0.0")x4")
        }
        enteredDataArray[0].append(-b1.doubleValue())
        enteredDataArray[1].append(-b2.doubleValue())
        
        enteredDataString[1].append(contentsOf: " = \(b1.text ?? "0.0")")
        enteredDataString[2].append(contentsOf: " = \(b2.text ?? "0.0")")
        if sise > 2 {
            enteredDataArray[2].append(-b3.doubleValue())
            enteredDataString[3].append(contentsOf: " = \(b3.text ?? "0.0")")
        }
        if sise > 3 {
            enteredDataArray[3].append(-b4.doubleValue())
            enteredDataString[4].append(contentsOf: " = \(b4.text ?? "0.0")")
        }
        resultString = enteredDataString.joined(separator:"\n")
    }
    
    func makeStringArray(n: Int, text: Bool) {
        var enteredDataString: [String] = []
        for i in 0..<n {
            enteredDataString.append("")
            for j in 0..<n {
                if j > 0 {
                    enteredDataString[i].append(contentsOf: " + ")
                }
                enteredDataString[i].append(contentsOf: "\(enteredDataArray[i][j].rounded(digits: 4))x\(j+1)")
            }
            enteredDataString[i].append(contentsOf: " + \(enteredDataArray[i][n].rounded(digits: 4)) = 0")
        }
        if text {
            resultString.append(contentsOf: "\n\nПриводимо дану систему до вигляду, зручного для релаксації:\n")
        }
        resultString.append(contentsOf: enteredDataString.joined(separator:"\n"))
    }
    
    func checkDiagonalDominance() {
        if segmentControl.selectedSegmentIndex == 0 {
            enteredDataArray = [[ 0.9996, 0.0012, -0.0003, -5.9988],
                                [-0.0005, 1.0017,  0.0005, -4.9969],
                                [-0.0007,  0.002,  0.9996, -1.9977]]
            resultString.append(contentsOf: """
                    \n\nПеретворимо матрицю на матрицю з діаголальним домінуванням
                    Виконаємо перетворення системи Ах = B
                    до вигляду x - ax - b = 0, де
                    a = A * 𝛆
                    b = (A^-1 - 𝛆) * B

                                -12  -1  -8
                    A^-1 =   -9  -1   6
                                  -7  -1   5
                    
                           0.0004  -0.00012   0.0003
                    𝛆 =  0.0005  -0.00017  -0.0005
                           0.0007      -0.002   0.0003

                    Отримаємо:\n
                    """)
            makeStringArray(n: 3, text: false)
        }
    }
    
    /// Реалізація методу релаксації
    func relaxation() {
        checkDiagonalDominance()
        let n = enteredDataArray.count
        /// Перетворити систему до вигляду, зручного для релаксації
        for i in 0..<n {
            let mainElem = enteredDataArray[i][i]
            if mainElem > 0 {
                for j in 0..<n + 1 {
                    enteredDataArray[i][j] = enteredDataArray[i][j] * (-1) / mainElem
                }
            } else {
                for j in 0..<n + 1 {
                    enteredDataArray[i][j] = enteredDataArray[i][j] * (-1) / mainElem
                }
            }
        }
        makeStringArray(n: n, text: true)
        
        /// Масив наближень
        /// Початкові наближення коренів - нульові значення
        var approximation: [[Double]] = Array(repeating: [0.0], count: n)
        var maxR = 0.0
        var nMaxR = 0
        resultString.append(contentsOf: "\n\nВибираючи як початкові наближення коренів нульові значення, знаходимо відповідні їм нев'язки:")
        for i in 0..<n {
            var ri = 0.0
            /// Для кожного елемента
            for j in 0..<n {
                if i != j {
                    /// Початкові наближення коренів - нульові значення
                    ri += 0.0 * enteredDataArray[i][j]
                }
            }
            ri += enteredDataArray[i][n]
            approximation[i].append(ri)
            resultString.append(contentsOf: "\nR\(i+1) = \(ri.rounded(digits: 3))")
            if maxR < ri {
                maxR = ri
                nMaxR = i
            }
        }
        resultString.append(contentsOf: "\nМаксимальна нев'язка: R\(nMaxR+1) = |\(maxR.rounded(digits: 5))|")
        /// Значення для перевіки умови закінцення наступного циклу
        var check: Double = 0.0
        /// Лічильник кількості циклів
        var k = 0
        /// Повторюється поки задана точність не буде досягнута
        repeat {
            /// Виклик ф-ї, що знаходить наступні наближення коренів
            check = findNextApproximation(n, &nMaxR, &approximation, k)
            k += 1
            
            if abs(check) > epsilonValue {
                resultString.append(contentsOf: "\n|\(check.rounded(digits: 5))| > 𝛆 = \(epsilonValue)")
            } else {
                resultString.append(contentsOf: "\n|\(check.rounded(digits: 5))| < 𝛆 = \(epsilonValue)")
            }
        } while abs(check) > epsilonValue
        
        resultString.append(contentsOf: "\n\nЗадана точність була досягнута.\nРезультат:")
        var answer: [Double] = []
        /// Обчислення результату
        for i in 0..<n {
            var x = 0.0
            for j in stride(from: approximation[i].count - 1, to: 0, by: -1) {
                if approximation[i][j] == 0.0 {
                    x += approximation[i][j - 1]
                }
            }
            answer.append(x)
            resultString.append(contentsOf: "\nx\(i+1) = \(x.rounded(digits: 5))")
        }
    }

    /**
    Знаходить наступні наближення коренів
    - Parameters:
       - n: розмір матриці
       - nMaxR: індех максимальної нев'язки
       - approximation: масив наближень
       - iterationN: номер ітерації
    - Returns: найбільшу за модулем нев'язку
    */
    func findNextApproximation(_ n: Int, _ nMaxR: inout Int, _ approximation: inout [[Double]], _ iterationN: Int) -> Double {
        resultString.append(contentsOf: "\n\nІтерація №\(iterationN + 1)\nЗначення нев'язок:")
        var newMaxR = 0.0
        var newNMaxR = 0
        var epsilonCheck = 0.0
        for i in 0..<n {
            var newR = 0.0
            /// обчиснення нев'язки
            if i != nMaxR {
                newR = approximation[i][iterationN + 1] + enteredDataArray[i][nMaxR] * approximation[nMaxR][iterationN + 1]
                resultString.append(contentsOf: "\nR\(i+1) = \(approximation[i][iterationN + 1].rounded(digits: 3)) + \(enteredDataArray[i][nMaxR].rounded(digits: 3)) * \(approximation[nMaxR][iterationN + 1].rounded(digits: 3)) = \(newR.rounded(digits: 5))")
            } else {
                newR = 0.0
                resultString.append(contentsOf: "\nR\(i+1) = \(newR)")
            }
            approximation[i].append(newR)
            /// пошук найбільшої нев'язки
            if abs(newMaxR) <= abs(newR) {
                newMaxR = newR
                newNMaxR = i
            }
            if abs(epsilonCheck) < abs(newR) {
                epsilonCheck = newR
            }
        }
        resultString.append(contentsOf: "\nМаксимальна нев'язка: R\(newNMaxR+1) = |\(newMaxR.rounded(digits: 5))|")
        nMaxR = newNMaxR
        return epsilonCheck
    }
    
    
    @IBAction func didChangedStepper(_ sender: UIStepper) {
        if sender.value < 4 {
            stackView4.isHidden = true
            view14.isHidden = true
            view24.isHidden = true
            view34.isHidden = true
            x13Label.text = "x3="
            x23Label.text = "x3="
            x33Label.text = "x3="
            
            if sender.value < 3 {
                stackView3.isHidden = true
                view13.isHidden = true
                view23.isHidden = true
                x12Label.text = "x2="
                x22Label.text = "x2="
            }
        }
        if sender.value > 2 {
            stackView3.isHidden = false
            view13.isHidden = false
            view23.isHidden = false
            x12Label.text = "x2+"
            x22Label.text = "x2+"
            
            if sender.value > 3 {
                stackView4.isHidden = false
                view14.isHidden = false
                view24.isHidden = false
                view34.isHidden = false
                x13Label.text = "x3+"
                x23Label.text = "x3+"
                x33Label.text = "x3+"
            }
        }
        stepperValue = Int(sender.value)
    }
    
    
    func setMyVariant() {
        steper.value = 3
        
        x11.text = "1"
        x12.text = "-3"
        x13.text = "2"
        
        x21.text = "3"
        x22.text = "-4"
        x23.text = "0"
        
        x31.text = "2"
        x32.text = "-5"
        x33.text = "3"
        
        b1.text = "-5"
        b2.text = "-2"
        b3.text = "-7"
    }
    
    
    @IBAction func didChangeSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            setMyVariant()
        case 1:
            x11.text = ""
            x12.text = ""
            x13.text = ""
            x14.text = ""
            
            x21.text = ""
            x22.text = ""
            x23.text = ""
            x24.text = ""
            
            x31.text = ""
            x32.text = ""
            x33.text = ""
            x44.text = ""
            
            b1.text = ""
            b2.text = ""
            b3.text = ""
            b4.text = ""
        default:
            print("default")
        }
    }
    
    
    @IBAction func didPressCalculateButton(_ sender: UIButton) {
        makeAnArray(sise: stepperValue)
        epsilonValue = Double(epsilon.text ?? "0.01") ?? 0.01
        relaxation()
        
        guard let resultVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab5ResultViewController") as? Lab5ResultViewController else { return }
        resultVC.bigText = resultString
        let navigationC = UINavigationController()
        navigationC.viewControllers = [resultVC]
        present(navigationC, animated: true, completion: nil)
        print(resultString)
    }
    
}


extension UITextField {
    func doubleValue() -> Double {
        return Double(self.text ?? "" ) ?? 0.0
    }
}
