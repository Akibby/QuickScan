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
*/

import UIKit

class POLTableViewController: UITableViewController {
    
    // MARK: - Properties
    /*
     Features of the device table.
     */
    var pols: [POL]!

    // Loads the page.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Checks to see if any pols are saved and loads samples if not.
        if let savedPOLs = loadPOLs(){
            pols = savedPOLs
        }
        else{
            loadSamplePOLs()
        }
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Creates sample POLs.
    func loadSamplePOLs(){
        let pol1 = POL(lawNum: "115935", po: "2457-0-FMI", nickname: "Monitors", sessions: [Session]())!
        let pol2 = POL(lawNum: "328174", po: "2445-0-FMI", nickname: "Tiny Order", sessions: [Session]())!
        pols = [pol1,pol2]
    }
    
    // MARK: - Table view data source
    /*
     Defines how the table should be built
     */
    
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

    // Allows for editing the table.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            pols.removeAtIndex(indexPath.row)
            savePOLs()
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

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

    // MARK: - NSCoding
    /*
     Functions for saving.
     */
    
    // Will save the changes to the pols array.
    func savePOLs(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pols, toFile: POL.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save session!")
        }
        else{
            print("Session Saved!")
        }
    }
    
    // Loads any saved POL arrays.
    func loadPOLs() -> [POL]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(POL.ArchiveURL.path!) as? [POL]
    }
    
    // MARK: - Navigation
    /*
     Navigation to and from the page.
     */
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "POLSelected"{
            let nav = segue.destinationViewController as! SessionTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            nav.pols = pols
            nav.POLIndex = selectedIndexPath!.row
        }
    }
    
    // Handles when a page that was navigated to returns back to the table.
    @IBAction func unwindToPOLList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? NewPOL, pol = sourceViewController.pol {
            let newIndexPath = NSIndexPath(forRow: pols.count, inSection: 0)
            pols.append(pol)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        savePOLs()
    }
}