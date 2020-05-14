//
//  Lab5ResultViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 14.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class Lab5ResultViewController: UIViewController {

    @IBOutlet weak var mainTextView: UITextView!
    public var bigText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTextView.text = bigText
    }
    
}
