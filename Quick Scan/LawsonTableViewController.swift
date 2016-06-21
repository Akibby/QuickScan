//
//  LawsonTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/8/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class LawsonTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    var labels = [["Device Info","Model","Type","Nickname","Notes", "Capital"],["Location Info","City","Building","Department","Company"]]
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    @IBOutlet weak var modNum: UITextField!
    @IBOutlet weak var nickname: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var typeLabel: UILabel!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notes.delegate = self
        self.modNum.delegate = self
        self.nickname.delegate = self
        
        print(modNum.text)
        print(cityLabel.text)
        checkValidEntries()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    /*
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing
        saveButton.enabled = false
    }
    */
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidEntries()
    }
    
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return labels.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return labels[section].count - 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return labels[section][0]
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let model = modNum.text
        let nick = nickname.text
        let note = notes.text
        let city = cityLabel.text
        let building = buildingLabel.text
        let department = departmentLabel.text
        let company = companyLabel.text
        let devices = [Device]()
        
        if saveButton === sender{
            session = Session(lawNum: pols[POLIndex].lawNum, po: pols[POLIndex].po, model: model!, nickname: nick!, notes: note!, dept: department!, bldg: building!, comp: company!, city: city!, devices: devices)
        }
    }
    
    // MARK: Actions
    /*
    func correctPO(po: String) -> String{
        var temp1 = po
        var temp2 = po
        var temp3 = po
        let dash = "-"
        if !po.containsString(dash){
            let suffix1 = temp1.endIndex.advancedBy(-4)..<temp1.endIndex
            let suffix2 = temp2.endIndex.advancedBy(-3)..<temp2.endIndex
            
            temp1.removeRange(suffix1)
            temp2.removeRange(suffix2)
            
            let prefix2 = temp2.startIndex..<temp2.startIndex.advancedBy(4)
            let prefix3 = temp3.startIndex..<temp3.startIndex.advancedBy(5)
            
            temp2.removeRange(prefix2)
            temp3.removeRange(prefix3)
            
            let fixedpo = temp1 + dash + temp2 + dash + temp3
            print(fixedpo)
            return fixedpo
        }
        else{
            return po
        }
    }
    */
    @IBAction func unwindToLawsonTable(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? CityTableViewController{
            city = sourceViewController.city
            cityLabel.text = city
            print(city)
        }
        if let sourceViewController = sender.sourceViewController as? BuildingTableViewController{
            building = sourceViewController.building
            buildingLabel.text = building
            print(building)
        }
        if let sourceViewController = sender.sourceViewController as? DepartmentTableViewController{
            department = sourceViewController.department
            departmentLabel.text = department
            print(department)
        }
        if let sourceViewController = sender.sourceViewController as? CompanyTableViewController{
            company = sourceViewController.company
            companyLabel.text = company
            print(company)
        }
        if let sourceViewController = sender.sourceViewController as? TypeTableViewController{
            type = sourceViewController.type
            typeLabel.text = type
            print(type)
        }
        checkValidEntries()
    }
}




























