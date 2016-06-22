//
//  POLTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class POLTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var pols: [POL]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedPOLs = loadPOLs(){
            pols = savedPOLs
        }
        else{
            loadSamplePOLs()
            print("Samples created")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSamplePOLs(){
        let law = "123456789"
        let po = "QWER-T-FM1"
        
        let pol1 = POL(lawNum: law, po: po, nickname: "pol1", sessions: [Session]())!
        let pol2 = POL(lawNum: law, po: po, nickname: "pol2", sessions: [Session]())!
        let pol3 = POL(lawNum: law, po: po, nickname: "pol3", sessions: [Session]())!
        
        pols = [pol1,pol2,pol3]
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pols.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "POLCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! POLTableViewCell
        
        let pol = pols[indexPath.row]
        
        cell.nickname.text = pol.nickname
        cell.POL.text = pol.lawNum + " - " + pol.po

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "POLSelected"{
            let nav = segue.destinationViewController as! UINavigationController
            let svc = nav.topViewController as! SessionTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            
            svc.pols = pols
            svc.POLIndex = selectedIndexPath!.row
        }
    }
    
    @IBAction func unwindToPOLList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? NewPOLViewController, pol = sourceViewController.pol {
            let newIndexPath = NSIndexPath(forRow: pols.count, inSection: 0)
            pols.append(pol)
            print(pols.count)
            print(pols[pols.count - 1].nickname)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        savePOLs()
    }
    
    // MARK: NSCoding
    
    func savePOLs(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pols, toFile: POL.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save session!")
        }
        else{
            print("Session Saved!")
        }
    }
    
    func loadPOLs() -> [POL]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(POL.ArchiveURL.path!) as? [POL]
    }
}















































