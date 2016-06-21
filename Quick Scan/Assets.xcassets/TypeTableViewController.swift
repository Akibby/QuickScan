//
//  TypeTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class TypeTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var typeTitles = ["Desktops","Monitors","Thin Client","Printers","Mobile Carts","Laptops","Phones","Other"]
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var type: String!
    var oldIndex: NSIndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        return typeTitles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TypeCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = typeTitles[indexPath.row]
        if oldIndex == nil{
            doneButton.enabled = false
        }
        
        return cell
    }
    
    // MARK: = Actions
    
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
            type = typeTitles[(selectedIndexPath?.row)!]
        }
    }
}



























