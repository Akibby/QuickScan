//
//  NewSession.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/8/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Allows for creation of a new Session Object. The new Session will be added to the Session Array for the selected POL.
 
    Completion Status: Complete!
*/

import UIKit

class NewSession: UITableViewController, UITextFieldDelegate, CaptuvoEventsProtocol {
    
    // MARK: Properties
    /*
     Features of the new device page.
     */
    
    // Array that defines how the page should be built.
    var labels = [["Device Info","Model","Type","Nickname","Notes", "Capital"],["Location Info","City","Building","Department","Company"]]
    
    // Connects buttons, text fields, and labels to code.
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var modNum: UITextField!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var capSwitch: UISwitch!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    var city: String!
    var building: String!
    var department: String!
    var company: String!
    var type: String!
    var session: Session?
    var sessions: [Session]!
    var pol: POL!
    var pols: [POL]!
    var POLIndex: Int!
    var capital: Bool!
    
    // Loads the page.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handles the text fields inputs.
        self.notes.delegate = self
        self.modNum.delegate = self
        self.nickname.delegate = self
        
        if pols[POLIndex].sessions.count > 0{
            let template = pols[POLIndex].sessions[0]
            cityLabel.text = template.city
            buildingLabel.text = template.bldg
            departmentLabel.text = template.dept
            companyLabel.text = template.comp
        }
        
        // Initializes the Captuvo scanner.
        Captuvo.sharedCaptuvoDevice().addCaptuvoDelegate(self)
        Captuvo.sharedCaptuvoDevice().startDecoderHardware()
        
        checkValidEntries()
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
    /*
     Defines how the program should react to changes in the text fields.
     */
    
    // Hide the keyboard.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Checks all fields for valid entries.
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidEntries()
    }
    
    // Checks all fields for valid entries and decides if the save button should be enabled.
    func checkValidEntries(){
        let mod = modNum.text ?? ""
        
        if (!mod.isEmpty && typeLabel.text != "Type" && cityLabel.text! != "City" && buildingLabel.text != "Building" && departmentLabel.text != "Department" && companyLabel.text != "Company"){
            saveButton.enabled = true
        }
        else{
            saveButton.enabled = false
        }
    }
    
    // MARK: - Table view data source
    /*
     Defines how the table should be built
     */
    
    // Defines the number of sections in the table.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return labels.count
    }
    
    // Defines the number of rows in a section.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels[section].count - 1
    }
    
    // Defines the labels for each section.
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return labels[section][0]
    }

    // MARK: - Navigation
    /*
     Navigation to and from the page.
     */
    
    // Prepares data to be sent to a different page by creating a session object with the defined parameters.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let model = modNum.text
            let nick = nickname.text
            let note = notes.text
            let city = cityLabel.text
            let building = buildingLabel.text
            let department = departmentLabel.text
            let company = companyLabel.text
            let devices = [Device]()
            let type = typeLabel.text
            let capital = capSwitch.on
            session = Session(model: model!, nickname: nick!, notes: note!, type: type!, capital: capital, dept: department!, bldg: building!, comp: company!, city: city!, devices: devices, submit: true)
            pols[POLIndex].sessions.append(session!)
        }
        if segue.identifier == "NewSession"{
            let nav = segue.destinationViewController as! DeviceTableViewController
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sesIndex =  pols[POLIndex].sessions.count - 1
            nav.newSes = true
        }
    }
    
    // MARK: - Actions
    /*
     Action functions.
     */
    
    // Handles when a page that was navigated to returns back to the table.
    @IBAction func unwindToLawsonTable(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? CityTableViewController{
            city = sourceViewController.city
            cityLabel.text = city
        }
        if let sourceViewController = sender.sourceViewController as? BuildingTableViewController{
            building = sourceViewController.building
            buildingLabel.text = building
        }
        if let sourceViewController = sender.sourceViewController as? DepartmentTableViewController{
            department = sourceViewController.department
            departmentLabel.text = department
        }
        if let sourceViewController = sender.sourceViewController as? CompanyTableViewController{
            company = sourceViewController.company
            companyLabel.text = company
        }
        if let sourceViewController = sender.sourceViewController as? TypeTableViewController{
            type = sourceViewController.type
            typeLabel.text = type
        }
        checkValidEntries()
    }
    
    // MARK: - Captuvo
    /*
     Functions to for the Captuvo scanner.
     */
    
    // Starts the decoder.
    func captuvoConnected() {
        Captuvo.sharedCaptuvoDevice().startDecoderHardware()
    }
    
    // Stops the decoder.
    func captuvoDisconnected() {
        Captuvo.sharedCaptuvoDevice().stopDecoderHardware()
    }
    
    // Decides where data from the scanner belongs.
    func decoderDataReceived(data: String!) {
        modNum.text = data
    }
}