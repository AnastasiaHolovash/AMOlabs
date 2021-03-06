//
//  Lab1Task2ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 20.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class Lab1Task2ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var kTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    @IBOutlet weak var pTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    
    ///Appears when c*k = p.
    func alert() -> UIAlertController {
        let alert = UIAlertController(title: "c * k = p", message: "The result is not provided by the algorithm", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okBtn)
        return alert
    }
    
    func hideKeybourd() {
        aTextField.resignFirstResponder()
        kTextField.resignFirstResponder()
        cTextField.resignFirstResponder()
        pTextField.resignFirstResponder()
        showResultLab1Tack2()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeybourd()
        return true
    }
    
    @IBAction func didPressResultButton(_ sender: UIButton) {
        hideKeybourd()
    }
    
    func showResultLab1Tack2() {
        guard let a = aTextField.text,
             let k = kTextField.text,
             let c = cTextField.text,
             let p = pTextField.text else { return }

        let doubleA = Double(a.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        let doubleK = Double(k.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        let doubleC = Double(c.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        let doubleP = Double(p.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        
        var y = 0.0
        if (doubleK * doubleC) > doubleP {
            y = pow(sin(doubleA * doubleC), 2)
        } else if (doubleK * doubleC) < doubleP {
            y = pow(cos(doubleA * doubleK), 2)
        } else {
            present(alert(), animated: true, completion: nil)
        }
           
        resultLabel.text = String(y)
           
    }
    
    @IBAction func didPressDiagram(_ sender: UIButton) {
        let image = UIImage(named: "DiagramTask2")
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else { return }
           
           vc.image = image
           present(vc, animated: true, completion: nil)
    }
    

}
