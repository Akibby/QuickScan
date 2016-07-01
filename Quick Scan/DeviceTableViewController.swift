//
//  DeviceTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Displays the array of Devices contained within the selected Session.
 
    Completion Status: Partially Complete!
*/

import UIKit
import MessageUI

class DeviceTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    /*
     Features of the device table.
     */
    // var pol: POL!
    var pols: [POL]!
    var POLIndex: Int!
    var sesIndex: Int!
    var fileName: String! = ""
    var cursub: [Int]! = []
    // Connects the submit and done buttons to code.
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // Loads the table.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Function to decide the file name for converting to .csv.
        fileName = pols[POLIndex].sessions[sesIndex].nickname
        if fileName == ""{
            fileName = pols[POLIndex].po
        }
        else{
            fileName = fileName + "_" + pols[POLIndex].po
        }
        
        // Function to decide what the navigation title will be.
        if pols[POLIndex].sessions[sesIndex].nickname != ""{
            navigationItem.title = pols[POLIndex].sessions[sesIndex].nickname
        }
        else{
            navigationItem.title = pols[POLIndex].lawNum
        }
        
        // Checks value of needQuickUpdate() and sets the submit button to either enabled or disabled.
        if needQuickUpdate() == true{
            submitButton.enabled = true
        }
        else{
            submitButton.enabled = false
        }
        
        // navigationItem.leftBarButtonItem = editButtonItem()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // Function from Apple to handle memory.
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
        return pols[POLIndex].sessions[sesIndex].devices.count
    }

    // Builds the cells for the table.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DeviceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DeviceTableViewCell
        
        let device = pols[POLIndex].sessions[sesIndex].devices[indexPath.row]
        
        cell.serialLabel.text = device.serialNum
        cell.photoImageView.image = device.photo
        cell.assetLabel.text = device.assetTag
        
        return cell
    }
    
    // Allows for editing the table.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            pols[POLIndex].sessions[sesIndex].devices.removeAtIndex(indexPath.row)
            
            savePOLs()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - NSCoding
    /*
     Functions for saving.
     */
    
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
    /*
     Navigation to and from the page.
     */
    
    // Prepares data to be sent to a different page.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"{
            let nav = segue.destinationViewController as! DeviceInfoViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sesIndex = sesIndex
            nav.devIndex = selectedIndexPath?.row
        }
    }
    
    
    // MARK: - Actions
    /*
     Action functions.
     */
    
    // Handles when a page that was navigated to returns back to the table.
    @IBAction func unwindToDeviceList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? NewDevice, device = sourceViewController.device{
            // Add new device
            let newIndexPath = NSIndexPath(forRow: pols[POLIndex].sessions[sesIndex].devices.count, inSection: 0)
            pols[POLIndex].sessions[sesIndex].devices.append(device)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        if needQuickUpdate() == true{
            submitButton.enabled = true
        }
        else{
            submitButton.enabled = false
        }
        savePOLs()
    }

    /*
     Converts all devices that need submission in the Session in to their .csv format.
     Functionally complete but tweaking exact output info.
     This function DOES change the submission status of each device that it converts!
     */
    func convertCSV(devices: [Device]) -> NSString{
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first{
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(fileName)
            // let mystring = "devType,department,building,company,city,idLawsonRequisitionNo,poQuoteNo,devAssetTag,devSerial,poNickname,devNotes,scanTimeIn,devModel,"
            let mystring = "Device Type,Status,Asset Tag,Serial Number,Department,Building/Location,Company,City,Floor,Warranty Expiration Date,PO Number,Procure All Number,Model,Capital/Non Capital,Notes\n"
            // var contentsOfFile = mystring + "idPurchaseOrder,poStatus,poOrderDate,poRecievedDate,Lawson_idLawsonRequisitionNo,idDevice,devDescription,devClass,devManufacturer,devManufacturerPartNo,devWarrantyDuratoinYears,devWarrantyExpiration,devServiceTag,devMonitorSizeInches,PurchaseOrder_idPurchaseOrder,PurchaseOrder_Lawson_idLawsonRequisitionNo\n"
            // var contentsOfFile = "idLawsonRequisitionNo,idPurchaseOrder,poStatus,poNickname,poQuoteNo,poOrderDate,poRecievedDate,Lawson_idLawsonRequisitionNo,idDevice,devSerial,devAssetTag,devDescription,devType,devClass,devManufacturer,devManufacturerPartNo,devModel,devWarrantyDuratoinYears,devWarrantyExpiration,devServiceTag,devMonitorSizeInches,devNotes,scanTimeIn,PurchaseOrder_idPurchaseOrder,PurchaseOrder_Lawson_idLawsonRequisitionNo\n"
            var contentsOfFile = mystring
            var i = 0
            let pol = pols[POLIndex]
            let ses = pol.sessions[sesIndex]
            while i < devices.count {
                if devices[i].submit == false{
                    devices[i].submit = true
                    let department = ses.dept.uppercaseString
                    let building = ses.bldg.uppercaseString
                    let company = ses.comp.uppercaseString
                    let city = ses.city.uppercaseString
                    let law = pol.lawNum.uppercaseString
                    let asset = devices[i].assetTag.uppercaseString
                    let serial = devices[i].serialNum.uppercaseString
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
                    var time = devices[i].time
                    time = time.dateByAddingTimeInterval(60*60*24*365*3)
                    let warranty = time.description
                    
                    contentsOfFile = contentsOfFile + type + "," + status + "," + asset + "," + serial + "," + department + "," + building + "," + company + ",\"" + city + "\"," + floor + "," + warranty + "," + po + "," + law + "," + model + "," + capital + "," + notes + "\n"
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
     Connects submit button to code.
     Was originally implemented to display a popup with a list of choices on how to react.
     Old code is left incase design plans change.
     */
    @IBAction func actionSheet(sender: AnyObject) {
        self.needUpdate()
        self.emailCSV()
        /*
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        /*
        let returnAction = UIAlertAction(title: "Save and Return to Session Table", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.savePOLs()
            self.dismissViewControllerAnimated(true, completion: nil)
            print("returning")
        })
        
        let submitAction = UIAlertAction(title: "Submit to Database", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.saveSession()
            self.postToServer(self)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        */
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
            self.cursub = []
        })
        
        let emailAction = UIAlertAction(title: "Email CSV", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.savePOLs()
            self.emailCSV()
        })
        /*
        if needUpdate() == true{
            // optionMenu.addAction(submitAction)
            optionMenu.addAction(emailAction)
        }
        */
        // optionMenu.addAction(returnAction)
        optionMenu.addAction(emailAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
        */
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
    
    // MARK: - Upload
    /*
     Functions that are releated to submitting data.
     */
    
    
    /*
     Function to post data to a server.
     Implementation incomplete!
     */
    @IBAction func postToServer(sender: AnyObject) {
        let url: NSURL = NSURL(string: "http://192.168.1.202")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let bodyData = "data=something"
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        //NSURLSession dataTaskWithRequest(request)
        /*NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            (response, data, error) in
            print(response)
        }*/
        print(convertCSV(pols[POLIndex].sessions[sesIndex].devices))
        
        /*
        let urlPath: String = "http://192.168.1.202"
        let url: NSURL = NSURL(string: urlPath)!
        let request1: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request1.HTTPMethod = "POST"
        let stringPost="deviceToken=123456"
        
        let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)
        
        request1.timeoutInterval = 60
        request1.HTTPBody = data
        request1.HTTPShouldHandleCookies = false
        let queue:NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue){_,_,_ in 
            
        }
        */
    }
    
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
        let contents = convertCSV(pols[POLIndex].sessions[sesIndex].devices)
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
     If the mail view returns 2 (email sent) as its result cursub is set to an empty array and the view is dismissed.
     If the mail view returns any other result cursub will be indexed and all devices will have that were being submitted will have their submission status returned to false.
     */
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        if result.rawValue != 2{
            var i = 0
            while i < cursub.count {
                pols[POLIndex].sessions[sesIndex].devices[cursub[i]].submit = false
                i += 1
            }
        }
        else{
            controller.dismissViewControllerAnimated(true, completion: nil)
            // self.dismissViewControllerAnimated(true, completion: nil)
            self.performSegueWithIdentifier("unwindToSessionList", sender: nil)
        }
        cursub = []
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}




















