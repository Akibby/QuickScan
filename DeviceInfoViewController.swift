//
//  DeviceInfoViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/30/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Displays information about a specific device.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class DeviceInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    // Ties the labels on the page to code.
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var poLabel: UILabel!
    @IBOutlet weak var lawLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var deptLabel: UILabel!
    @IBOutlet weak var compLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    // Passes the pol array and the indexes to the page.
    var pols: [POL]!
    var POLIndex: Int!
    var sesIndex: Int!
    var devIndex: Int!

    // Fills in the labels with data from the selected device.
    override func viewDidLoad() {
        super.viewDidLoad()
        let pol = pols[POLIndex]
        let session = pol.sessions[sesIndex]
        let device = session.devices[devIndex]
        serialLabel.text = device.serialNum
        assetLabel.text = device.assetTag
        typeLabel.text = session.type
        poLabel.text = pol.po
        lawLabel.text = pol.lawNum
        cityLabel.text = session.city
        buildLabel.text = shortenBuilding(session.bldg)
        deptLabel.text = shortenDepartment(session.dept)
        compLabel.text = session.comp
        notesLabel.text = session.notes
        if session.capital{
            capitalLabel.text = "Capital"
        }
        else{
            capitalLabel.text = "Non-Capital"
        }
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    // Shortens the building text by remove the prefix
    func shortenBuilding(building: String) -> String{
        var bldg = building
        let range = bldg.startIndex..<bldg.startIndex.advancedBy(6)
        bldg.removeRange(range)
        
        return bldg
    }
    
    // Shortens the department text by remove the prefix
    func shortenDepartment(department: String) -> String{
        var dept = department
        let range = dept.startIndex..<dept.startIndex.advancedBy(5)
        dept.removeRange(range)
        
        return dept
    }
}