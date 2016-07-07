//
//  TypeTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the Type List.
 
    Completion Status: Complete!
 */

import UIKit

class TypeTableViewController: UITableViewController {
    
    // MARK: - Properties
    /*
     Features of the type table view controller.
     */
    
    // An array of strings that are the different types.
//    Add Scanners ??
    var typeTitles = ["Desktops","Monitors","Thin Client","Printers","Scanners","Mobile Carts","Laptops","Phones","Routers","Switches","UPS","Other"]
    var type: String!

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
    /*
     Defines how the table should be built.
     */

    // Defines the number of sections in the table.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // Defines the number of rows in the table.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeTitles.count
    }
    
    // Function to build the cells.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TypeCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.adjustsFontSizeToFitWidth.description
        cell.textLabel?.text = typeTitles[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation
    /*
     Navigation to and from the page.
     */
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        type = typeTitles[(selectedIndexPath?.row)!]
    }
}