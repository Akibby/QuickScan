//
//  LawsonTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/8/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class LawsonTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var labels = [["Law","Notes"],["City","Building","Department","Company"]]
    
    @IBOutlet weak var lawNum: UITextField!
    @IBOutlet weak var notes: UITextField!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    
    var city: String!
    var building: String!
    var department: String!
    var company: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return labels.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return labels[section].count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "POEntered"{
            let nav = segue.destinationViewController as! UINavigationController
            let svc = nav.topViewController as! DeviceTableViewController
            svc.lawNum = lawNum.text
            svc.notes = notes.text
            svc.city = city
            svc.building = building
            svc.department = department
            svc.company = company
        }
    }
    
    // MARK: Actions
    
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
    }
    
}




























