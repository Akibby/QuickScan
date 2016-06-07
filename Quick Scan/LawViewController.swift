//
//  LawViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/2/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class LawViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var lawNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "POEntered"{
            let nav = segue.destinationViewController as! UINavigationController
            let svc = nav.topViewController as! DeviceTableViewController
            svc.lawNum = lawNumber.text
        }
    }
}