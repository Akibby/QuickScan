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
    
    // MARK: - Attributes
    /*
     Connects the labels on the page to code.
     */
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var assetTagLabel: UILabel!
    @IBOutlet weak var serialNumLabel: UILabel!
    @IBOutlet weak var lawNumLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var poNumLabel: UILabel!
    
    // Initailizes an empty device to be passed to the page.
    var device: Device?

    // Fills in the labels with data from the selected device.
    override func viewDidLoad() {
        super.viewDidLoad()
        if let device = device {
            assetTagLabel.text = device.assetTag
            serialNumLabel.text = device.serialNum
        }
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    /*
     Functions to handle navigation from the page.
     */
    
    // Dismisses the page when cancel is passed.
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Function to prepare data to be sent to a new page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
