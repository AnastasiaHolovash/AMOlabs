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
//    @IBOutlet weak var resultButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        resultButton.layer.cornerRadius = CGFloat((Double(resultButton.frame.height) ) / 2.0)
//
//        // Hides the resultButton moving it down
//        UIView.animate(withDuration: 0) {
//        self.resultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
//        }
//
//        // Listen for keyboard events
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    deinit {
//        // Stop listening for keyboard show/hide events
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
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
    
//    @objc func keyboardWillChange(notification: Notification){
//        
//        if notification.name.rawValue == "UIKeyboardWillShowNotification"{
//            UIView.animate(withDuration: 2) {
//                self.resultButton.transform = CGAffineTransform(translationX: 0, y: 0)
//            }
//        }else{
//            UIView.animate(withDuration: 2) {
//                self.resultButton.transform = CGAffineTransform(translationX: 0, y: self.view.center.y)
//            }
//        }
//    }
    
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

