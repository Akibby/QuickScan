//
//  POLTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Displays all POLs (POL: PO-Lawson) saved on device.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class POLTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // Initializes variables.
    var pols: [POL]!
    
    // Loads the page.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks to see if any pols are saved and loads them.
        if let savedPOLs = loadPOLs(){
            pols = savedPOLs
        }
        else{
            pols = []
        }
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
    
    // Defines the number of cells in the table.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pols.count
    }

    // Builds the cells for the table.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "POLCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! POLTableViewCell
        let pol = pols[indexPath.row]
        cell.nickname.text = pol.nickname
        cell.POL.text = pol.lawNum + " - " + pol.po

        return cell
    }

    // Allows for deleting from the table.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            pols.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            savePOLs()
        }
    }
    
    // MARK: - NSCoding
    
    // Will save the changes to the POL array.
    func savePOLs(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pols, toFile: POL.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save session!")
        }
        else{
            print("Session Saved!")
        }
    }
    
    // Loads any saved POL array.
    func loadPOLs() -> [POL]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(POL.ArchiveURL.path!) as? [POL]
    }
    
    // MARK: - Navigation
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "POLSelected"{
            savePOLs()
            let nav = segue.destinationViewController as! SessionTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            nav.pols = pols
            nav.POLIndex = selectedIndexPath!.row
        }
        if segue.identifier == "NewPOL"{
            let nav = segue.destinationViewController as! NewPOL
            nav.pols = pols
        }
    }
    
    // Handles when a page that was navigated to returns back to the table.
    @IBAction func unwindToPOLList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? SessionTableViewController{
            pols = sourceViewController.pols
            if sourceViewController.newPOL{
                let newIndexPath = NSIndexPath(forRow: pols.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .None)
            }
        }
        savePOLs()
    }
}