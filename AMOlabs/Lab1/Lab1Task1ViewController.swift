//
//  ViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 17.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class Lab1Task1ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    func hideKeybourd() {
        aTextField.resignFirstResponder()
        xTextField.resignFirstResponder()
        cTextField.resignFirstResponder()
        showResultLab1Tack1()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeybourd()
        return true
    }
    

    
    @IBAction func didPressResult(_ sender: UIButton) {
        hideKeybourd()
    }
    
    func showResultLab1Tack1() {
        guard let a = aTextField.text,
              let x = xTextField.text,
              let c = cTextField.text else { return }
 
        let doubleA = Double(a.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        let doubleX = Double(x.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        let doubleC = Double(c.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        let result = (pow((doubleA + doubleX), 2) / 5) + (pow((doubleA + doubleC), 3) / 2)
        
        resultLabel.text = String(result)
        
    }
    @IBAction func didPressDiagram(_ sender: UIButton) {
        let image = UIImage(named: "DiagramTask1")
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else { return }
           
           vc.image = image
           present(vc, animated: true, completion: nil)
    }
    
   

}

