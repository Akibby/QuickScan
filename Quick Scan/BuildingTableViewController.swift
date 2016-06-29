//
//  BuildingTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/7/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the Building List.
 
    Completion Status: Complete!
*/

import UIKit

class BuildingTableViewController: UITableViewController {
    
    // MARK: - Properties
    /*
     Features of the type table view controller.
     */
    
    // An array of  arrays of strings that are the different buildings grouped by location.
    var buildingTitles = [["FMOLHS","FML - 2051 Silverside - IS","FML - 7612 Picardy #G-F Legal","FML - FMOL Health System","FML - Info Svcs Perkins Rd","FML - Ollie Steele"],["Our Lady of the Lake","LAK - 5120 Dijon Building - Bus Off.","LAK - 5128 Dijon - Acct.","LAK - 5311 Dijon - H/R","LAK - 5421 Didesse Suites A & B","LAK - 5745 Essen Crossing","LAK - Assumption Rural Health Clinic","LAK - Asumption Community Hospital","LAK - Baton Rouge Clinic","LAK - Bone & Joint Clinic","LAK - Goodwood","LAK - Imaging Center","LAK - MOB 1","LAK - MOB 2","LAK - MOB 3","LAK - Neighborhood Clinic Scotlandville","LAK - Our Lady of the LAKe OLOL Main","LAK - PCN 12 - Southeast Pediatrics","LAK - PCN 15 - Carl E. McLemore, Jr.","LAK - PCN 18 - Brian J. LeBlanc","LAK - PCN 2 - Family Practice Associates","LAK - PCN 24 - Paul B. Rachel","LAK - PCN 25 LPCP S. BR","LAK - PCN 28 - Senior Care","LAK - PCN 33 Pediatrics O'Neal","LAK - PCN 36 - Pediatrics Denham","LAK - PCN 39 - Dr. Carol Smothers","LAK - PCN 41","LAK - PCN 7 - Louis V. Montelaro","LAK - PCN 9 - Pediatric Medical Center","LAK - Plaza I","LAK - Silverside","LAK - St. Anthony","LAK - St. Claire","LAK - Storage Bldg Rm 133","LAK - Storage Bldg Rm 134","LAK - Storage Bldg Rm 135","LAK - Storage Bldg Rm 136","LAK - Tau Center","LAK - Villa St. Francis"],["College","COL - Admin Building - Perkins","COL - Health Career Institute","COL - Health Science & Health Science An","COL - Liberal Arts - Brittany","COL - Library - Didesse","COL - Nursing Building - Hennessy","COL - OLOL College of Nursing Main","COL - Science Building - Brittany","COL - Student Services - Brittany"]]
    
    // Connection to the done button.
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var building: String!
    var oldIndex: NSIndexPath!
    
    // Loads the table.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
     Defines how the table should be built
     */
    
    // Defines the number of sections in the table.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return buildingTitles.count
    }

    // Defines the number of rows in a section.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildingTitles[section].count - 1
    }

    // Function to build the cells.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = buildingTitles[indexPath.section][indexPath.row + 1]
        if oldIndex == nil{
            doneButton.enabled = false
        }
        return cell
    }
    
    // Creates the headers for the sections.
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return buildingTitles[section][0]
    }
    
    // MARK: - Actions
    /*
     Action functions.
     */
    
    //  Adds checkmark to the selected cell and removes checkmark from last selected if needed.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if oldIndex != nil{
            tableView.cellForRowAtIndexPath(oldIndex)?.accessoryType = UITableViewCellAccessoryType.None
        }
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        doneButton.enabled = true
        oldIndex = indexPath
    }
    
    // MARK: - Navigation
    /*
     Navigation to and from the page.
     */
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender{
            let selectedIndexPath = tableView.indexPathForSelectedRow
            building = buildingTitles[(selectedIndexPath?.section)!][(selectedIndexPath?.row)! + 1]
        }
    }
}




















































