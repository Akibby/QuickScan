//
//  SessionTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/9/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class SessionTableViewController: UITableViewController {
    
    // MARK: Properties
    
    // var pol: POL!
    var pols: [POL]!
    var POLIndex: Int!
    // var sessions: [Session]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem()
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
        return pols[POLIndex].sessions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ScanSessionCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SessionTableViewCell
        let session = pols[POLIndex].sessions[indexPath.row]
        
        cell.lawNum.text = session.model + " - " + session.type
        cell.nickname.text = session.nickname
        
        /*
        if session.nickname != ""{
            cell.nickname.text = session.nickname
        }
        */

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
            // session.devices.removeAtIndex(indexPath.row)
            pols[POLIndex].sessions.removeAtIndex(indexPath.row)
            savePOLs()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SessionSelected"{
            let nav = segue.destinationViewController as! UINavigationController
            let svc = nav.topViewController as! DeviceTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            // let session = pols[POLIndex].sessions[(selectedIndexPath?.row)!]
            svc.pol = pols[POLIndex]
            svc.pols = pols
            svc.POLIndex = POLIndex
            svc.sesIndex = selectedIndexPath?.row
        }
        if segue.identifier == "NewSession"{
            let nav = segue.destinationViewController as! NewSession
            // svc.sessions = sessions
            nav.pol = pols[POLIndex]
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sessions = pols[POLIndex].sessions
        }
    }
 
    
    // MARK: - Actions
    
    @IBAction func unwindToSessionList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? NewSession, session = sourceViewController.session{
            let newIndexPath = NSIndexPath(forRow: pols[POLIndex].sessions.count, inSection: 0)
            pols[POLIndex].sessions.append(session)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        savePOLs()
        let new = pols[POLIndex].sessions.count - 1
        print(pols[POLIndex].sessions[new].nickname)
    }
    
    // MARK: - NSCoding
    
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














































