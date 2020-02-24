//
//  Extensions.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 24.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
