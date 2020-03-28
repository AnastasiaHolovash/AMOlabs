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
//    @IBOutlet weak var errorTableViewCell: UITableViewCell!
//    @IBOutlet weak var nLabel: UILabel!
//    @IBOutlet weak var errorLabel: UILabel!
//    @IBOutlet weak var differenceLabel: UILabel!
//    @IBOutlet weak var coefficientLabel: UILabel!
    
    var numbers: [Int] = []
    var interpolationError: [Double] = []
    /// the difference between interpolated and exact values
    var interpolatedAndExactDifference: [Double] = []
    /// the refinement coefficient of the interpolated value
    var refinementCoefficient: [Double] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorTableview.delegate = self
        errorTableview.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = errorTableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ErrorTableViewCell
        
        cell.nLabel.text = String(numbers[indexPath.row])
        cell.errorLabel.text = String(interpolationError[indexPath.row])
        cell.differenceLabel.text = String(interpolatedAndExactDifference[indexPath.row])
        cell.coefficientLabel.text = String(refinementCoefficient[indexPath.row])

        return cell
    }
    
    
}
