//
//  DeviceTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Displays the array of Devices contained within the selected Session.
    Completion Status: Complete!
    Last Update v1.0
 */

import UIKit
import MessageUI

class DeviceTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    // Connects the submit button to code.
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    // Initializes variables.
    var pols: [POL]!
    var POLIndex: Int!
    var sesIndex: Int!
    var fileName: String! = ""
    var cursub: [Int]! = []
    var newSes = false
    
    // Loads the table.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savePOLs()
        nameFile()
        chooseTitle()
        
        // Checks value of needQuickUpdate() and sets the submit button to either enabled or disabled.
        if needQuickUpdate(){
            submitButton.enabled = true
        }
        else{
            submitButton.enabled = false
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
        return pols[POLIndex].sessions[sesIndex].devices.count
    }

    // Builds the cells for the table.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DeviceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DeviceTableViewCell
        let device = pols[POLIndex].sessions[sesIndex].devices[indexPath.row]
        cell.serialLabel.text = "Serial - " + device.serialNum
        cell.photoImageView.image = device.photo
        cell.assetLabel.text = "Asset - " + device.assetTag
        
        return cell
    }
    
    // Allows for deleting from the table.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            pols[POLIndex].sessions[sesIndex].devices.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            savePOLs()
            if !needQuickUpdate(){
                submitButton.enabled = false
            }
        }
    }
    
    // MARK: - NSCoding
    
    // Will save the changes to the current device array.
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
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewDevice"{
            let nav = segue.destinationViewController as! NewDevice
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sesIndex = sesIndex
        }
        else if segue.identifier == "DeviceSelected"{
            let nav = segue.destinationViewController as! DeviceInfoViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sesIndex = sesIndex
            nav.devIndex = selectedIndexPath?.row
        }
    }
    
    // Adds new devices upon returning from NewDevice.swift
    @IBAction func unwindToDeviceList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? NewDevice{
            Captuvo.sharedCaptuvoDevice().stopDecoderScanning()
            var newDevices = sourceViewController.newDevices
            var newIndexPath: NSIndexPath
            var i = 0
            while i < newDevices.count {
                pols[POLIndex].sessions[sesIndex].devices.append(newDevices[i])
                newIndexPath = NSIndexPath(forRow: tableView.numberOfRowsInSection(0), inSection: 0)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                i += 1
                submitButton.enabled = true
            }
        }
        if !needQuickUpdate(){
            submitButton.enabled = false
        }
        savePOLs()
    }
    
    // MARK: - Actions
    
    // Decides a file name for the csv.
    func nameFile(){
        fileName = pols[POLIndex].sessions[sesIndex].nickname
        if fileName == ""{
            fileName = pols[POLIndex].po
        }
        else{
            fileName = fileName + "_" + pols[POLIndex].po
        }
    }
    
    // Decides title that will be displayed.
    func chooseTitle(){
        if pols[POLIndex].sessions[sesIndex].nickname != ""{
            navigationItem.title = pols[POLIndex].sessions[sesIndex].nickname
        }
        else{
            navigationItem.title = pols[POLIndex].lawNum
        }
    }
    
    /*
     Goes through every device in the array and checks to see if it has been submitted or not.
     If not submitted already it will store index of the object in the cursub array.
     Function will return a boolean value to decide if the DB needs an update.
     This function DOES NOT change the submission status of any of the devices!
     */
    func needUpdate() -> Bool{
        let curdevs = pols[POLIndex].sessions[sesIndex].devices
        let devcount = curdevs.count
        var tf = false
        var i = 0
        
        while i < devcount {
            if curdevs[i].submit == false{
                if cursub == nil{
                    cursub = [i]
                }
                else{
                    cursub.append(i)
                }
                tf = true
            }
            else if cursub.count == 0{
                tf = false
            }
            i += 1
        }
        return tf
    }
    
    /*
     Similar to needUpdate() but it only runs until it finds one device that needs an update.
     Does NOT store any indexes to cursub or change any submission statuses!
     */
    func needQuickUpdate() -> Bool {
        let curdevs = pols[POLIndex].sessions[sesIndex].devices
        var i = 0
        while i < curdevs.count {
            if curdevs[i].submit == false{
                return true
            }
            i += 1
        }
        return false
    }
    
    // Function called by pressing the submit button.
    @IBAction func submitPressed(sender: AnyObject) {
        self.needUpdate()
        self.emailCSV()
    }
    
    /*
     Converts all devices that need submission in the Session in to their .csv format.
     This function DOES change the submission status of each device that it converts!
     */
    func convertCSV(devices: [Device]) -> NSString{
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first{
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(fileName)
            let mystring = "Device Type,Status,Asset Tag,Serial Number,Department,Building/Location,Company,City,Floor,Warranty Expiration Date,PO Number,Procure All Number,Model,Capital/Non Capital,Notes\n"
            var contentsOfFile = mystring
            var i = 0
            let pol = pols[POLIndex]
            let ses = pol.sessions[sesIndex]
            while i < devices.count {
                if devices[i].submit == false{
                    let department = ses.dept.uppercaseString
                    let building = ses.bldg.uppercaseString
                    let company = ses.comp.uppercaseString
                    let city = ses.city.uppercaseString
                    let law = pol.lawNum.uppercaseString
                    let asset = devices[i].assetTag.uppercaseString
                    let serial = devices[i].serialNum.uppercaseString
                    let notes = ses.notes.uppercaseString
                    let warranty = devices[i].time
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
                    contentsOfFile = contentsOfFile + type + "," + status + "," + asset + "," + serial + "," + department + "," + building + "," + company + ",\"" + city + "\"," + floor + "," + warranty + "," + po + "," + law + "," + model + "," + capital + "," + notes + "\n"
                    devices[i].submit = true
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
    
    // Sets the submission status on all recently submitted devices to false.
    func unsubmit(){
        var i = 0
        while i < cursub.count {
            pols[POLIndex].sessions[sesIndex].devices[cursub[i]].submit = false
            i += 1
        }
    }
    
    // MARK: - Email
    
    // Function to pull up the email page using the email composer defined by configuredMailComposeViewController().
    func emailCSV(){
        let emailViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(emailViewController, animated: true, completion: nil)
        }
    }
    
    // Configures an email view with auto filled in information.
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let contents = convertCSV(pols[POLIndex].sessions[sesIndex].devices)
        let data = contents.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let emailController = MFMailComposeViewController()
        let serviceEmail = "svc_LakeReceiving@fmolhs.org"
        
        emailController.canResignFirstResponder()
        emailController.mailComposeDelegate = self
        emailController.setToRecipients([serviceEmail])
        emailController.setSubject(fileName + " CSV File")
        emailController.setMessageBody("Data for \n" + "Lawson Number: " + pols[POLIndex].lawNum + "\n PO Number: " + pols[POLIndex].po, isHTML: false)
        emailController.addAttachmentData(data!, mimeType: "text/csv", fileName: fileName + ".csv")
        
        return emailController
    }
    
    /*
     Handles the mail view closing.
     If the mail view returns 2 (email sent) as its result cursub is set to an empty array and the view is dismissed.
     If the mail view returns any other result the devices will be unsubmitted.
     */
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        if result.rawValue != 2{
            unsubmit()
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            print("Closing email page!")
            controller.dismissViewControllerAnimated(true, completion: nil)
            print("Closing device list!")
            self.performSegueWithIdentifier("unwindToSessionList", sender: nil)
        }
        cursub = []
    }
}