//
//  CityTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/7/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var cityTitles = ["Baton Rouge, La", "Carencro, La","Crowley, La","Denham Springs, La","Donaldsville, La","Dutchtown, La","Gamercy, La","Gonzales, La","Lafayette, La","Monroe, La","Napoleonville, La","New Orleans, La","New Roads, La","Praireville, La","West Monroe, La"]
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var city: String!
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
        return cityTitles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "LocationTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)

        cell.textLabel?.text = cityTitles[indexPath.row]
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender{
            let selectedIndexPath = tableView.indexPathForSelectedRow
            city = cityTitles[(selectedIndexPath?.row)!]
        }
    }
}































