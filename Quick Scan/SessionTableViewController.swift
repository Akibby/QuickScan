//
//  SessionTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/9/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit
import MessageUI

class SessionTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    var pols: [POL]!
    var POLIndex: Int!
    var fileName: String! = ""
    var cursub = [Int]()
    var curdevsub = [[Int]]()
    @IBOutlet weak var submitButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileName = pols[POLIndex].nickname
        if fileName == ""{
            fileName = pols[POLIndex].po
        }
        else{
            fileName = fileName + "_" + pols[POLIndex].po
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        
        if needUpdate() == true{
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pols[POLIndex].sessions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("Building cell")
        let cellIdentifier = "ScanSessionCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SessionTableViewCell
        let session = pols[POLIndex].sessions[indexPath.row]
        
        
        cell.nickname.text = session.nickname
        
        if session.submit == true{
            cell.lawNum.text = session.model + " - " + session.type
            print("Cell submitted")
        }
        else{
            cell.lawNum.text = session.model + " - " + session.type
            print("Cell needs submission")
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
            pols[POLIndex].sessions.removeAtIndex(indexPath.row)
            savePOLs()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SessionSelected"{
            let nav = segue.destinationViewController as! UINavigationController
            let svc = nav.topViewController as! DeviceTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            svc.pol = pols[POLIndex]
            svc.pols = pols
            svc.POLIndex = POLIndex
            svc.sesIndex = selectedIndexPath?.row
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
    
    @IBAction func submitPressed(sender: AnyObject) {
        emailCSV()
    }
    
    
    @IBAction func unwindToSessionList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? NewSession, session = sourceViewController.session{
            let newIndexPath = NSIndexPath(forRow: pols[POLIndex].sessions.count, inSection: 0)
            pols[POLIndex].sessions.append(session)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        else if let sourceViewController = sender.sourceViewController as? DeviceTableViewController{
            print("Unwinding to session table")
            print("")
            if sourceViewController.needQuickUpdate(){
                pols[POLIndex].sessions[sourceViewController.sesIndex].submit = false
                print("Update needed still!")
            }
            else{
                pols[POLIndex].sessions[sourceViewController.sesIndex].submit = true
                print("Session up to date!")
            }
        }
        savePOLs()
        if needUpdate() == true{
            submitButton.enabled = true
        }
        else{
            submitButton.enabled = false
        }
        let new = pols[POLIndex].sessions.count - 1
        print(pols[POLIndex].sessions[new].nickname)
    }
    
    func convertCSV(sessions: [Session]) -> NSString{
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first{
            print("filename = " + fileName)
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(fileName)
            print("contents created")
            let mystring = "department,building,company,city,idLawsonRequisitionNo,poQuoteNo,devAssetTag,devSerial,poNickname,devNotes,scanTimeIn,devModel,devType,"
            var contentsOfFile = mystring + "idPurchaseOrder,poStatus,poOrderDate,poRecievedDate,Lawson_idLawsonRequisitionNo,idDevice,devDescription,devClass,devManufacturer,devManufacturerPartNo,devWarrantyDuratoinYears,devWarrantyExpiration,devServiceTag,devMonitorSizeInches,PurchaseOrder_idPurchaseOrder,PurchaseOrder_Lawson_idLawsonRequisitionNo\n"
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
                            let time = dev.time.description.uppercaseString
                            let department = ses.dept.uppercaseString
                            let building = ses.bldg.uppercaseString
                            let company = ses.comp.uppercaseString
                            let city = ses.city.uppercaseString
                            let law = pol.lawNum.uppercaseString
                            let notes = ses.notes.uppercaseString
                            let po = pol.po.uppercaseString
                            let nickname = pol.nickname.uppercaseString + "-" + ses.nickname.uppercaseString
                            let model = ses.model.uppercaseString
                            let type = ses.type.uppercaseString
                            let capital = ses.capital.description.uppercaseString
                            
                            contentsOfFile = contentsOfFile + department + "," + building + "," + company + ",\"" + city + "\"," + law + "," + po + "," + asset + "," + serial + "," + nickname + "," + notes + "," + time + "," + model + "," + type + "," + capital + "\n"
                            
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
    
    func emailCSV(){
        let emailViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(emailViewController, animated: true, completion: nil)
        }
    }
    
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














































