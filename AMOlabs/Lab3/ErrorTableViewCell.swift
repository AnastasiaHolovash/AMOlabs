//
//  ErrorTableViewCell.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 28.03.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    @IBOutlet weak var coefficientLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nLabel.text = nil
        errorLabel.text = nil
        differenceLabel.text = nil
        coefficientLabel.text = nil 
    }
}
