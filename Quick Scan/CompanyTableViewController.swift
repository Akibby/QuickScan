//
//  CompanyTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/7/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the Company List.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class CompanyTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // An array of strings that are the different companies.
    var companyTitles = ["Assisi Village","Assumption","Calais Health","Calais Health LLC","Calais House","Chateau Louise","FMOL Health System","Franciscan Legal","Heart Hospital of Acadiana","Monroe Health Services","Monroe MRI","Ollie Steele","OLOL College","OLOL Foundation","Our Lady of Lourdes","Our Lady of the Lake RMC","PACE","Specialty Hospital","St Francis Ambulatory","St Francis Ins Agency","St Francis PET Imaging","St Patricks","St. Bernard","St. Elizabeth","St. Elizabeth Physicians","St. Francis Medical Center","St. Francis North","Vendor Computer","Villa St. Francis"]
    var company: String!
    
    // Loads the table.
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    // Defines the number of sections in the table.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Defines the number of rows in the table.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyTitles.count
    }

    // Function to build the cells.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LocationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = companyTitles[indexPath.row]
        return cell
    }
    

    // MARK: - Navigation
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        company = companyTitles[(selectedIndexPath?.row)!]
    }
}