//
//  CityTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/7/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the City List.
 
    Completion Status: Complete!
*/

import UIKit

class CityTableViewController: UITableViewController {
    
    // MARK: - Properties
    /*
     Features of the type table view controller.
     */
    
    // An array of strings that are the different cities.
    var cityTitles = ["Baton Rouge, La", "Carencro, La","Crowley, La","Denham Springs, La","Donaldsville, La","Dutchtown, La","Gamercy, La","Gonzales, La","Lafayette, La","Monroe, La","Napoleonville, La","New Orleans, La","New Roads, La","Praireville, La","West Monroe, La"]
    var city: String!
    
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
        return 1
    }

    // Defines the number of rows in the table.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityTitles.count
    }

    // Function to build the cells.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LocationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = cityTitles[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation
    /*
     Navigation to and from the page.
     */
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        city = cityTitles[(selectedIndexPath?.row)!]
    }
}































