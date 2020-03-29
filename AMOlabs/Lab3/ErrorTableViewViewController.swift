//
//  ErrorTableViewViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 28.03.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ErrorTableViewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var errorTableview: UITableView!
    
    var numbers: [Int] = []
    var interpolationError: [Double] = []
    /// the difference between interpolated and exact values
    var interpolatedAndExactDifference: [Double] = []
    /// the refinement coefficient of the interpolated value
    var refinementCoefficient: [Double] = []
    var x: Double = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Оцінка похибки для х = \(x)"
        errorTableview.delegate = self
        errorTableview.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = errorTableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ErrorTableViewCell
        if indexPath.row == 0 {
            cell.nLabel.text = "n"
            cell.errorLabel.text = "∆n"
            cell.differenceLabel.text = "∆exact n"
            cell.coefficientLabel.text = "k"
        } else {
            cell.nLabel.text = String(numbers[indexPath.row - 1])
//            cell.errorLabel.text = String(format: "%.5f", interpolationError[indexPath.row - 1])
            cell.errorLabel.attributedText = interpolationError[indexPath.row - 1].scientificFormatted
            cell.differenceLabel.attributedText = interpolatedAndExactDifference[indexPath.row - 1].scientificFormatted
            cell.coefficientLabel.attributedText = refinementCoefficient[indexPath.row - 1].scientificFormatted
        }
        

        return cell
    }
    
    
}
