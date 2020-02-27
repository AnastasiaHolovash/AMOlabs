//
//  ChartImageViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 26.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ChartImageViewController: UIViewController {

    @IBOutlet weak var chartImageView: UIImageView!
    @IBOutlet weak var chartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // setupActivityIndicator()
    }
    

//    private func setupActivityIndicator() {
//        activityIndicator.stopAnimating()
//        activityIndicator.isHidden = true
//        activityIndicator.color = .white
//
//        activityView.isHidden = true
//        activityView.layer.cornerRadius = 18
//        activityView.backgroundColor = UIColor.darkText
//    }
    
    @IBAction func didPressChartButton(_ sender: UIButton) {
//        // Stop activity indicator
//               activityIndicator.startAnimating()
//               activityIndicator.isHidden = false
//               activityView.isHidden = false
//               self.view.bringSubviewToFront(activityView)
               
               // Getting test result and showing charts
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 , execute: {
                 self.showChart()
               })
    }
    
    func showChart() {
        guard let chartVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChartViewController") as? ChartViewController else { return }
        
        guard let firstTaskLab2VC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab2ViewController") as? Lab2ViewController else { return }
        
        DispatchQueue.main.async {
            
            chartVC.valuesSegue = firstTaskLab2VC.getTestValues(count: 70)
//            chartVC.nSegue = self.sliderValue

            self.navigationController?.pushViewController(chartVC, animated: true)
        }
    }
    

}
