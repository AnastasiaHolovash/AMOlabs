//
//  ImageViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 24.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        if let graphImage = image {
            imageView.image = graphImage
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
