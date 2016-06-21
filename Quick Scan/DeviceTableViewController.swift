//
//  DeviceTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit
import MessageUI

class DeviceTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    // var session: Session!
    // var sessions: [Session]!
    var pol: POL!
    var pols: [POL]!
    var POLIndex: Int!
    var sesIndex: Int!
    var fileName: String! = ""
    var cursub: [Int]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(POLIndex)
        print(sesIndex)
        print(fileName)
        fileName = pols[POLIndex].sessions[sesIndex].nickname
        print("fileName set")
        if fileName == ""{
            fileName = pols[POLIndex].sessions[sesIndex].po
        }
        else{
            fileName = fileName + "_" + pols[POLIndex].sessions[sesIndex].po
        }
        print(fileName)
        
        
        if pols[POLIndex].sessions[sesIndex].nickname != ""{
            navigationItem.title = pols[POLIndex].sessions[sesIndex].nickname
        }
        else{
            navigationItem.title = pols[POLIndex].sessions[sesIndex].lawNum
        }
        
        navigationItem.leftBarButtonItem = editButtonItem()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pols[POLIndex].sessions[sesIndex].devices.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DeviceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DeviceTableViewCell
        
        // let device = session.devices[indexPath.row]
        let device = pols[POLIndex].sessions[sesIndex].devices[indexPath.row]
        
        
        cell.serialLabel.text = device.serialNum
        // cell.typeLabel.text = device.type
        cell.photoImageView.image = device.photo
        print(device.submit)
        
        if device.submit{
            cell.assetLabel.text = device.assetTag + " - S"
        }
        else{
            cell.assetLabel.text = device.assetTag
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
            pols[POLIndex].sessions[sesIndex].devices.removeAtIndex(indexPath.row)
            
            savePOLs()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"{
            let nav = segue.destinationViewController as! DeviceInfoViewController
            // let deviceInfo = deviceInfoViewController.topViewController as! DeviceInfoViewController
             if let selectedViewCell = sender as? DeviceTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedViewCell)!
                // let selectedDevice = session.devices[indexPath.row]
                let selectedDevice = pols[POLIndex].sessions[sesIndex].devices[indexPath.row]
                nav.device = selectedDevice
            }
        }
        else if segue.identifier == "AddNew"{
            let nav = segue.destinationViewController as! ViewController
            // let svc = nav.topViewController as! ViewController
            nav.lawNum = pols[POLIndex].sessions[sesIndex].lawNum
            nav.poNum = pols[POLIndex].sessions[sesIndex].po
            nav.notes = pols[POLIndex].sessions[sesIndex].notes
            nav.city = pols[POLIndex].sessions[sesIndex].city
            nav.building = pols[POLIndex].sessions[sesIndex].bldg
            nav.department = pols[POLIndex].sessions[sesIndex].dept
            nav.company = pols[POLIndex].sessions[sesIndex].comp
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func unwindToDeviceList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? ViewController, device = sourceViewController.device{
            // Add new device
            let newIndexPath = NSIndexPath(forRow: pols[POLIndex].sessions[sesIndex].devices.count, inSection: 0)
            pols[POLIndex].sessions[sesIndex].devices.append(device)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        savePOLs()
    }
    
    func convertCSV(devices: [Device]) -> NSString{
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first{
            print("filename = " + fileName)
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(fileName)
            print("contents created")
            let mystring = "department,building,company,city,idLawsonRequisitionNo,poQuoteNo,devAssetTag,devSerial,poNickname,devNotes,scanTimeIn,devModel,"
            var contentsOfFile = mystring + "idPurchaseOrder,poStatus,poOrderDate,poRecievedDate,Lawson_idLawsonRequisitionNo,idDevice,devDescription,devType,devClass,devManufacturer,devManufacturerPartNo,devWarrantyDuratoinYears,devWarrantyExpiration,devServiceTag,devMonitorSizeInches,PurchaseOrder_idPurchaseOrder,PurchaseOrder_Lawson_idLawsonRequisitionNo\n"
            // var contentsOfFile = "idLawsonRequisitionNo,idPurchaseOrder,poStatus,poNickname,poQuoteNo,poOrderDate,poRecievedDate,Lawson_idLawsonRequisitionNo,idDevice,devSerial,devAssetTag,devDescription,devType,devClass,devManufacturer,devManufacturerPartNo,devModel,devWarrantyDuratoinYears,devWarrantyExpiration,devServiceTag,devMonitorSizeInches,devNotes,scanTimeIn,PurchaseOrder_idPurchaseOrder,PurchaseOrder_Lawson_idLawsonRequisitionNo\n"
            var i = 0
            while i < devices.count {
                if devices[i].submit == false{
                    devices[i].submit = true
                    print(devices[i].assetTag)
                    let department = devices[i].department.uppercaseString
                    let building = devices[i].building.uppercaseString
                    let company = devices[i].company.uppercaseString
                    let city = devices[i].city.uppercaseString
                    let law = devices[i].law.uppercaseString
                    let asset = devices[i].assetTag.uppercaseString
                    let serial = devices[i].serialNum.uppercaseString
                    let notes = devices[i].notes.uppercaseString
                    let po = devices[i].poNum.uppercaseString
                    let ponickname = pols[POLIndex].sessions[sesIndex].nickname.uppercaseString
                    let time = devices[i].time.description
                    let model = devices[i].model.uppercaseString
                    
                    contentsOfFile = contentsOfFile + department + "," + building + "," + company + ",\"" + city + "\"," + law + "," + po + "," + asset + "," + serial + "," + ponickname + "," + notes + "," + time + "," + model + "\n"
                    print("content added")
                    i += 1
                }
                else{
                    i += 1
                }
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
    
    @IBAction func actionSheet(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let returnAction = UIAlertAction(title: "Save and Return to Session Table", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.savePOLs()
            self.dismissViewControllerAnimated(true, completion: nil)
            print("returning")
        })
        /*
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
        
        if needUpdate() == true{
            // optionMenu.addAction(submitAction)
            optionMenu.addAction(emailAction)
        }
        optionMenu.addAction(returnAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    func needUpdate() -> Bool{
        let curses = pols[POLIndex].sessions[sesIndex]
        let curdevs = curses.devices
        let devcount = curses.devices.count
        var tf = false
        var i = 0
        
        while i < devcount {
            if curdevs[i].submit == false{
                if cursub == nil{
                    print("cursub is nil")
                    cursub = [i]
                }
                else{
                    print("cursub isn't nil")
                    cursub.append(i)
                }
                print(cursub)
                tf = true
                i += 1
            }
            else if cursub.count == 0{
                tf = false
                i += 1
            }
        }
        return tf
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
    /*
    func loadPOLs() -> [POL]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(POL.ArchiveURL.path!) as? [POL]
    }
    */
    // MARK: Upload
    
    @IBAction func postToServer(sender: AnyObject) {
        print("Submitting")
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
    
    
    func emailCSV(){
        let emailViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(emailViewController, animated: true, completion: nil)
        }
    }
    
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let contents = convertCSV(pols[POLIndex].sessions[sesIndex].devices)
        let data = contents.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let emailController = MFMailComposeViewController()
        
        emailController.canResignFirstResponder()
        emailController.mailComposeDelegate = self
        emailController.setSubject(fileName + " CSV File")
        emailController.setMessageBody("Data for \n" + "Lawson Number: " + pols[POLIndex].sessions[sesIndex].lawNum + "\n PO Number: " + pols[POLIndex].sessions[sesIndex].po, isHTML: false)
        emailController.addAttachmentData(data!, mimeType: "text/csv", fileName: fileName + ".csv")
        
        
        return emailController
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        print(result)
        if result.rawValue == 0{
            var i = 0
            while i < cursub.count {
                pols[POLIndex].sessions[sesIndex].devices[cursub[i]].submit = false
                i += 1
            }
        }
        else{
            
        }
        cursub = []
        controller.dismissViewControllerAnimated(true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}




















