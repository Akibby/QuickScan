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
*/

import UIKit

class CompanyTableViewController: UITableViewController {
    
    var companyTitles = ["Assisi Village","Assumption","Calais Health","Calais Health LLC","Calais House","Chateau Louise","FMOL Health System","Franciscan Legal","Heart Hospital of Acadiana","Monroe Health Services","Monroe MRI","Ollie Steele","OLOL College","OLOL Foundation","Our Lady of Lourdes","Our Lady of the Lake RMC","PACE","Specialty Hospital","St Francis Ambulatory","St Francis Ins Agency","St Francis PET Imaging","St Patricks","St. Bernard","St. Elizabeth","St. Elizabeth Physicians","St. Francis Medical Center","St. Francis North","Vendor Computer","Villa St. Francis"]
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var company: String!
    var oldIndex: NSIndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companyTitles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LocationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = companyTitles[indexPath.row]
        if oldIndex == nil{
            doneButton.enabled = false
        }

        return cell
    }
    
    // MARK: Actions
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if oldIndex != nil{
            tableView.cellForRowAtIndexPath(oldIndex)?.accessoryType = UITableViewCellAccessoryType.None
        }
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        doneButton.enabled = true
        oldIndex = indexPath
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender{
            let selectedIndexPath = tableView.indexPathForSelectedRow
            company = companyTitles[(selectedIndexPath?.row)!]
        }
    }
}

















