//
//  Lab1Task3ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 21.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class Lab1Task3ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var arrayLabel: UILabel!
    @IBOutlet weak var arrayALabel: UILabel!
    @IBOutlet weak var arrayBLabel: UILabel!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var firstArrayView: UIView!
    @IBOutlet weak var secondArrayView: UIView!
    @IBOutlet weak var readFromFileView: UIView!
    @IBOutlet weak var writeInFileView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manually()
        
        
    }

    
    func hideKeybourd() {
        firstTextField.resignFirstResponder()
        secondTextField.resignFirstResponder()
    }
     // MARK: Винести
    func prepareArrayForTextField(textField: UITextField) -> [Double] {
        let splited = (textField.text ?? "").split(separator: ",")
        var arrayA: [Double] = []
        
        for one in splited {
            let trimmed = String(one).trimmingCharacters(in: .whitespacesAndNewlines)
            arrayA.append(Double(trimmed) ?? 0.0)
        }
        
        return arrayA
    }
    func prepareArray(_ string: String) -> [Double] {
        let splited = string.split(separator: ",")
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        switch segmentControl.selectedSegmentIndex {
        case 0:
            
            let arrayA: [Double] = prepareArrayForTextField(textField: firstTextField)
            let arrayB: [Double] = prepareArrayForTextField(textField: secondTextField)
            
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
        return true
    }
    
    
    func manually () {
        firstLabel.text = "A[] :"
        secondLabel.text = "B[] :"
        firstTextField.placeholder = "Введіть елементи масиву"
        secondTextField.placeholder = "Введіть елементи масиву"
        firstTextField.text = ""
        secondTextField.text = ""
        firstArrayView.isHidden = false
        secondArrayView.isHidden = false
        readFromFileView.isHidden = true
        writeInFileView.isHidden = true

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
            firstArrayView.isHidden = false
            secondArrayView.isHidden = false
            readFromFileView.isHidden = true
            writeInFileView.isHidden = true
        
        case 2:
            firstArrayView.isHidden = true
            secondArrayView.isHidden = true
            readFromFileView.isHidden = false
            writeInFileView.isHidden = false
            
        default:
            firstLabel.text = " "
            secondLabel.text = " "
            firstTextField.placeholder = " "
            secondTextField.placeholder = " "
            firstTextField.text = ""
            secondTextField.text = ""
            firstArrayView.isHidden = false
            secondArrayView.isHidden = false
            readFromFileView.isHidden = true
            writeInFileView.isHidden = true
        }
    }
    
    
    @IBAction func didPressDiagram(_ sender: UIButton) {
        let image = UIImage(named: "DiagramTask3")
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else { return }
           
           vc.image = image
           present(vc, animated: true, completion: nil)
    }
    

    @IBAction func didPressReadFromFile(_ sender: UIButton) {
//        var array: [String] = []

        do {
            let text1 = try makeWritableCopy(named: "arrayA.txt", ofResourceFile: "arrayA.txt")
            let text2 = try makeWritableCopy(named: "arrayB.txt", ofResourceFile: "arrayB.txt")
            let arrayA = prepareArray(text1)
            let arrayB = prepareArray(text2)
            print(text1)
            
            print(text2)
            
            showResultLab1Tack3(arrayA, arrayB)
            
            arrayLabel.text = "Згенеровані масиви:"
            arrayALabel.text = "A: " + arrayA.description
            arrayBLabel.text = "B: " + arrayB.description
            
        } catch {
            
        }
    }

        
        func makeWritableCopy(named destFileName: String, ofResourceFile originalFileName: String) throws -> String {
            // Get Documents directory in app bundle
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
                fatalError("No document directory found in application bundle.")
            }

            // Get URL for dest file (in Documents directory)
            let writableFileURL = documentsDirectory.appendingPathComponent(destFileName)

            // If dest file doesn’t exist yet
            if (try? writableFileURL.checkResourceIsReachable()) == nil {
                // Get original (unwritable) file’s URL
                guard let originalFileURL = Bundle.main.url(forResource: originalFileName, withExtension: nil) else {
                    fatalError("Cannot find original file “\(originalFileName)” in application bundle’s resources.")
                }

                // Get original file’s contents
                let originalContents = try Data(contentsOf: originalFileURL)

                // Write original file’s contents to dest file
                try originalContents.write(to: writableFileURL, options: .atomic)
                print("Made a writable copy of file “\(originalFileName)” in “\(documentsDirectory)\\\(destFileName)”.")

            } else { // Dest file already exists
                // Print dest file contents
                return try String(contentsOf: writableFileURL, encoding: String.Encoding.utf8)
    //            print("File “\(destFileName)” already exists in “\(documentsDirectory)”.\nContents:\n\(contents)")
            }
            
            return ""

        }
}


