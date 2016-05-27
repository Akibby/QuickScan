//
//  ViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var assetField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

