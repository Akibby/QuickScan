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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Defines the number of cells in the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pols.count
    }

    // Builds the cells for the table.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "POLCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! POLTableViewCell
        let pol = pols[indexPath.row]
        cell.nickname.text = pol.nickname
        cell.POL.text = pol.lawNum + " - " + pol.po

        return cell
    }

    // Allows for deleting from the table.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pols.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            savePOLs()
        }
    }
    
    // MARK: - NSCoding
    
    // Will save the changes to the POL array.
    func savePOLs(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pols, toFile: POL.ArchiveURL.path)
        if !isSuccessfulSave{
            print("Failed to save session!")
        }
        else{
            print("Session Saved!")
        }
    }
    
    // Loads any saved POL array.
    func loadPOLs() -> [POL]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: POL.ArchiveURL.path) as? [POL]
    }
    
    // MARK: - Navigation
    
    // Prepares data to be sent to a different page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "POLSelected"{
            savePOLs()
            let nav = segue.destination as! SessionTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            nav.pols = pols
            nav.POLIndex = selectedIndexPath!.row
        }
        if segue.identifier == "NewPOL"{
            let nav = segue.destination as! NewPOL
            nav.pols = pols
        }
    }
    
    // Handles when a page that was navigated to returns back to the table.
    @IBAction func unwindToPOLList(_ sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? SessionTableViewController{
            pols = sourceViewController.pols
            if sourceViewController.newPOL{
                let newIndexPath = IndexPath(row: pols.count - 1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .none)
            }
        }
        savePOLs()
    }
}
