//
//  DeviceInfoViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/30/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Displays information about a specific device.
 
    Completion Status: Incomplete!
*/

import UIKit

class DeviceInfoViewController: UIViewController {
    
    // MARK: Attributes
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var assetTagLabel: UILabel!
    @IBOutlet weak var serialNumLabel: UILabel!
    @IBOutlet weak var lawNumLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var poNumLabel: UILabel!
    
    
    var device: Device?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let device = device {
            assetTagLabel.text = device.assetTag
            serialNumLabel.text = device.serialNum
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
