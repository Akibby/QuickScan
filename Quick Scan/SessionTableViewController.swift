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
    
    var sessions: [Session]!
    var city: String!
    var building: String!
    var department: String!
    var company: String!
    var lawNum: String!
    var notes: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedSessions = loadSessions(){
            sessions = savedSessions
            print("Sessions loaded!")
        }
        else{
            loadSampleSession()
            print("Samples created!")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSampleSession(){
        city = "Baton Rouge, La"
        building = "FML - 2051 Silverside - IS"
        department = "LAKE-Oncology Outpatient-101-6056"
        company = "Calais Health"
        lawNum = "123456789"
        notes = "Nooooootes"
        
        let defaultPhoto = UIImage(named: "No Photo Selected")!
        let device1 = Device(assetTag: "1183176", serialNum: "MJ905EW", poNum: "09132478", type: "PC", photo: defaultPhoto, law: lawNum, notes: notes, city: city, building: building, department: department, company: company, submit: false)!
        let device2 = Device(assetTag: "1156296", serialNum: "MJ96G3F", poNum: "75092832", type: "PC", photo: defaultPhoto, law: lawNum, notes: notes, city: city, building: building, department: department, company: company, submit: false)!
        let device3 = Device(assetTag: "1155625", serialNum: "MJ75Z07", poNum: "57092834", type: "PC", photo: defaultPhoto, law: lawNum, notes: notes, city: city, building: building, department: department, company: company, submit: false)!
        
        let devices = [device1, device2, device3]
        
        let session1 = Session(lawNum: lawNum, po: "87327842", nickname: "Hard Drives", notes: notes, dept: department, bldg: building, comp: company, city: city, devices: devices)
        let session2 = Session(lawNum: lawNum, po: "75124512", nickname: "Monitors", notes: notes, dept: department, bldg: building, comp: company, city: city, devices: devices)
        let session3 = Session(lawNum: lawNum, po: "87124341", nickname: "Tiny Stock", notes: notes, dept: department, bldg: building, comp: company, city: city, devices: devices)
        sessions = [session1!, session2!, session3!]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sessions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ScanSessionCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SessionTableViewCell
        let session = sessions[indexPath.row]
        
        cell.lawNum.text = session.lawNum
        if session.nickname != ""{
            cell.nickname.text = session.nickname
        }

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
            sessions.removeAtIndex(indexPath.row)
            saveSessions()
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
            let session = sessions[(selectedIndexPath?.row)!]
            svc.session = session
            svc.sessions = sessions
            svc.sesIndex = selectedIndexPath?.row
        }
        if segue.identifier == "NewSession"{
            let nav = segue.destinationViewController as! UINavigationController
            let svc = nav.topViewController as! LawsonTableViewController
            svc.sessions = sessions
        }
    }
 
    
    // MARK: Actions
    
    @IBAction func unwindToSessionList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? LawsonTableViewController, session = sourceViewController.session{
            let newIndexPath = NSIndexPath(forRow: sessions.count, inSection: 0)
            sessions.append(session)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        saveSessions()
    }
    
    // MARK: NSCoding
    
    func saveSessions(){
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(sessions, toFile: Session.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save session!")
        }
        else{
            print("Session Saved!")
        }
    }
    
    func loadSessions() -> [Session]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Session.ArchiveURL.path!) as? [Session]
    }
}














































