//
//  WriteViewController.swift
//  AMOlabs
//
//  Created by Головаш Анастасия on 27.02.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var textView2: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Lab1Task3ViewController") as? Lab1Task3ViewController else { return }
            let text1 = try vc.makeWritableCopy(named: "arrayA.txt", ofResourceFile: "arrayA.txt")
            
            let text2 = try vc.makeWritableCopy(named: "arrayB.txt", ofResourceFile: "arrayB.txt")
            textView1.text = text1.description
            textView2.text = text2.description

            print(text2)
        } catch {
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let text1 = textView1.text ?? ""
        let text2 = textView2.text ?? ""

        

        // Write **text** to file
        do {
            let stuffFileURL1 = try makeWritableCopy(named: "arrayA.txt", ofResourceFile: "arrayA.txt")
            try text1.write(to: stuffFileURL1, atomically: true, encoding: String.Encoding.utf8)
            
            let stuffFileURL2 = try makeWritableCopy(named: "arrayB.txt", ofResourceFile: "arrayB.txt")
            try text2.write(to: stuffFileURL2, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            
        }        
    }

    
    func makeWritableCopy(named destFileName: String, ofResourceFile originalFileName: String) throws -> URL {
        // Get Documents directory in app bundle
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("No document directory found in application bundle.")
        }

        // Get URL for dest file (in Documents directory)
        let writableFileURL = documentsDirectory.appendingPathComponent(destFileName)

        // If dest file doesn’t exist yet
        if (try? writableFileURL.checkResourceIsReachable()) == nil {
            // Get original (unwritable) file’s URL
            guard let originalFileURL = Bundle.main.url(forResource: originalFileName, withExtension: nil) else {
                fatalError("Cannot find original file “\(originalFileName)” in application bundle’s resources.")
            }

            // Get original file’s contents
            let originalContents = try Data(contentsOf: originalFileURL)

            // Write original file’s contents to dest file
            try originalContents.write(to: writableFileURL, options: .atomic)
            print("Made a writable copy of file “\(originalFileName)” in “\(documentsDirectory)\\\(destFileName)”.")

        } else { // Dest file already exists
            // Print dest file contents
            let contents = try String(contentsOf: writableFileURL, encoding: String.Encoding.utf8)
            print("File “\(destFileName)” already exists in “\(documentsDirectory)”.\nContents:\n\(contents)")
        }

        // Return dest file URL
        return writableFileURL
    }

}
