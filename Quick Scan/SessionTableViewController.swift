//
//  SessionTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/9/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Displays the array of Sessions contained within the selected POL.
 
    Completion Status: Partially Complete!
 */

import UIKit
import MessageUI

class SessionTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    /*
     Features of the device table.
     */
    
    var pols: [POL]!
    var POLIndex: Int!
    var fileName: String! = ""
    var cursub = [Int]()
    var curdevsub = [[Int]]()
    @IBOutlet weak var submitButton: UIBarButtonItem!

    // Loads the page.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Decides a file name for the csv.
        fileName = pols[POLIndex].nickname
        if fileName == ""{
            fileName = pols[POLIndex].po
        }
        else{
            fileName = fileName + "_" + pols[POLIndex].po
        }
        
        if needQuickUpdate() == true{
            submitButton.enabled = true
        }
        else{
            submitButton.enabled = false
        }
    }

    
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

    // Defines the number of cells in the table.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pols[POLIndex].sessions.count
    }

    // Builds the cells for the table.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ScanSessionCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SessionTableViewCell
        let session = pols[POLIndex].sessions[indexPath.row]
        
        cell.nickname.text = session.nickname
        cell.lawNum.text = session.model + " - " + session.type
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            pols[POLIndex].sessions.removeAtIndex(indexPath.row)
            savePOLs()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - NSCoding
    /*
     Functions for saving.
     */
    
    // Will save the changes to the sessions array.
    func savePOLs(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pols, toFile: POL.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save session!")
        }
        else{
            print("Session Saved!")
        }
    }

    // MARK: - Navigation
    /*
     Navigation to and from the page.
     */
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SessionSelected"{
            let nav = segue.destinationViewController as! DeviceTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sesIndex = selectedIndexPath?.row
        }
        if segue.identifier == "NewSession"{
            let nav = segue.destinationViewController as! NewSession
            nav.pol = pols[POLIndex]
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sessions = pols[POLIndex].sessions
        }
    }
    
    
    // MARK: - Actions
    /*
     Action functions.
     */
    
    // Function for the submit button.
    @IBAction func submitPressed(sender: AnyObject) {
        needUpdate()
        emailCSV()
    }
    
    // Handles when a page that was navigated to returns back to the table.
    @IBAction func unwindToSessionList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? NewSession, session = sourceViewController.session{
            let newIndexPath = NSIndexPath(forRow: pols[POLIndex].sessions.count, inSection: 0)
            pols[POLIndex].sessions.append(session)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        else if let sourceViewController = sender.sourceViewController as? DeviceTableViewController{
            if sourceViewController.needQuickUpdate(){
                pols[POLIndex].sessions[sourceViewController.sesIndex].submit = false
            }
            else{
                pols[POLIndex].sessions[sourceViewController.sesIndex].submit = true
            }
        }
        savePOLs()
        if needQuickUpdate() == true{
            submitButton.enabled = true
        }
        else{
            submitButton.enabled = false
        }
    }
    
    /*
     Converts all devices in the Sessions that need submission in to their .csv format.
     Functionally complete but tweaking exact output info.
     This function DOES update the submission status of each device and session that it converts!
     */
    func convertCSV(sessions: [Session]) -> NSString{
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first{
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(fileName)
            let mystring = "Device Type,Status,Asset Tag,Serial Number,Department,Building/Location,Company,City,Floor,Warranty Expiration Date,PO Number,Procure All Number,Model,Capital/Non Capital,Notes\n"
            var contentsOfFile = mystring
//            var contentsOfFile = mystring + "idPurchaseOrder,poStatus,poOrderDate,poRecievedDate,Lawson_idLawsonRequisitionNo,idDevice,devDescription,devClass,devManufacturer,devManufacturerPartNo,devWarrantyDuratoinYears,devWarrantyExpiration,devServiceTag,devMonitorSizeInches,PurchaseOrder_idPurchaseOrder,PurchaseOrder_Lawson_idLawsonRequisitionNo\n"
            // var contentsOfFile = "idLawsonRequisitionNo,idPurchaseOrder,poStatus,poNickname,poQuoteNo,poOrderDate,poRecievedDate,Lawson_idLawsonRequisitionNo,idDevice,devSerial,devAssetTag,devDescription,devType,devClass,devManufacturer,devManufacturerPartNo,devModel,devWarrantyDuratoinYears,devWarrantyExpiration,devServiceTag,devMonitorSizeInches,devNotes,scanTimeIn,PurchaseOrder_idPurchaseOrder,PurchaseOrder_Lawson_idLawsonRequisitionNo\n"
            
            var i = 0
            let pol = pols[POLIndex]
            
            while i < sessions.count {
                if sessions[i].submit == false{
                    let ses = pol.sessions[i]
                    let devs = ses.devices
                    var j = 0
                    while j < devs.count{
                        if devs[j].submit == false{
                            let dev = devs[j]
                            let asset = dev.assetTag.uppercaseString
                            let serial = dev.serialNum.uppercaseString
                            let department = ses.dept.uppercaseString
                            let building = ses.bldg.uppercaseString
                            let company = ses.comp.uppercaseString
                            let city = ses.city.uppercaseString
                            let law = pol.lawNum.uppercaseString
                            let notes = ses.notes.uppercaseString
                            let po = pol.po.uppercaseString
                            let model = ses.model.uppercaseString
                            let type = ses.type.uppercaseString
                            let status = "In Use"
                            let floor = "1"
                            var capital: String
                            if ses.capital {
                                capital = "Capital"
                            }
                            else{
                                capital = "Non Capital"
                            }
                            var time = devs[i].time
                            time = time.dateByAddingTimeInterval(60*60*24*365*3)
                            let warranty = time.description
                            
                            contentsOfFile = contentsOfFile + type + "," + status + "," + asset + "," + serial + "," + department + "," + building + "," + company + ",\"" + city + "\"," + floor + "," + warranty + "," + po + "," + law + "," + model + "," + capital + "," + notes + "\n"
//                            contentsOfFile = contentsOfFile + department + "," + building + "," + company + ",\"" + city + "\"," + law + "," + po + "," + asset + "," + serial + "," + nickname + "," + notes + "," + time + "," + model + "," + type + "," + capital + "\n"
                            
                            pols[POLIndex].sessions[i].devices[j].submit = true
                        }
                        j += 1
                    }
                    pols[POLIndex].sessions[i].submit = true
                }
                i += 1
            }
            savePOLs()
            do {
                try contentsOfFile.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
                print("File created!")
            }
            catch{
                print("Failed to create file!")
            }
            
            do {
                let readFile = try NSString(contentsOfURL: path, encoding: NSUTF8StringEncoding)
                print("File read!")
                return readFile
            }
            catch{
                print("Failed to read file!")
            }
        }
        return "Failed to read!"
    }
    
    /*
     Checks each session to see if it needs submitted.
     If a session needs submission it will check every device within it to see if needs submission and appends a section to curdevsub for EVERY section.
     If the session is not submitted already it will store index of the object in the cursub array.
     If the device contained in the session is not submitted it will append it to curdevsub.
     Function will return a boolean value to decide if the DB needs an update.
     This function DOES NOT change the submission status of ANY OBJECT!
     */
    func needUpdate() -> Bool{
        let curses = pols[POLIndex].sessions
        let sescount = curses.count
        var tf = false
        var i = 0
        
        while i < sescount{
            curdevsub.append([])
            
            if curses[i].submit == false{
                cursub.append(i)
                let curdev = curses[i].devices
                let devcount = curdev.count
                var j = 0
                
                while j < devcount {
                    if curdev[j].submit == false{
                        curdevsub[i].append(j)
                    }
                    j += 1
                }
                tf = true
                i += 1
            }
            
            i += 1
        }
        return tf
    }
    
    /*
     Similar to needUpdate() but it only runs until it finds one session that needs an update.
     Does NOT store any indexes to cursub or curdevsub or change any submission statuses!
     */
    func needQuickUpdate() -> Bool{
        let curses = pols[POLIndex].sessions
        var i = 0
        
        while i < curses.count{
            if curses[i].submit == false{
                return true
            }
            i += 1
        }
        return false
    }
    
    /*
     Iterates through all indexes of cursub and uses the values to iterate through curdevsub and find which devices were updated.
     Then changes the submission status of the devices within each submitted session and session back to false.
     */
    func unsubmit(sessions: [Session]){
        var i = 0
        while i < cursub.count {
            pols[POLIndex].sessions[cursub[i]].submit = false
            var j = 0
            let subdevcount = curdevsub[i].count
            while j < subdevcount {
                pols[POLIndex].sessions[cursub[i]].devices[curdevsub[i][j]].submit = false
                j += 1
            }
            i += 1
        }
    }
    
    // MARK: - Upload
    /*
     Functions that are releated to submitting data.
     */
    
    /*
     Function to pull up the email page using the email composer defined by
     configuredMailComposeViewController().
     */
    func emailCSV(){
        let emailViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(emailViewController, animated: true, completion: nil)
        }
    }
    
    //Configures an email view with auto filled in information.
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let contents = convertCSV(pols[POLIndex].sessions)
        let data = contents.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let emailController = MFMailComposeViewController()
        
        emailController.canResignFirstResponder()
        emailController.mailComposeDelegate = self
        emailController.setSubject(fileName + " CSV File")
        emailController.setMessageBody("Data for \n" + "Lawson Number: " + pols[POLIndex].lawNum + "\n PO Number: " + pols[POLIndex].po, isHTML: false)
        emailController.addAttachmentData(data!, mimeType: "text/csv", fileName: fileName + ".csv")
        
        
        return emailController
    }
    
    /*
     Handles the mail view closing.
     If the mail view returns 2 (email sent) as its result cursub and curdevsub are set to empty arrays and the view is dismissed.
     If the mail view returns any other result the submitted sessions will be unsubmitted.
     */
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        print(result)
        if result.rawValue != 2{
            unsubmit(pols[POLIndex].sessions)
        }
        else{
            controller.dismissViewControllerAnimated(true, completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        cursub = []
        curdevsub = []
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}














































