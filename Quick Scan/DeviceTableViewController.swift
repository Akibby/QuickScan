//
//  DeviceTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class DeviceTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var session: Session!
    var sessions: [Session]!
    var sesIndex: Int!
    let fileName = "sample.csv"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = sessions[sesIndex].lawNum
        
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
        return sessions[sesIndex].devices.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DeviceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DeviceTableViewCell
        
        // let device = session.devices[indexPath.row]
        let device = sessions[sesIndex].devices[indexPath.row]
        
        cell.assetLabel.text = device.assetTag
        cell.serialLabel.text = device.serialNum
        cell.typeLabel.text = device.type
        cell.photoImageView.image = device.photo
        
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
            sessions[sesIndex].devices.removeAtIndex(indexPath.row)
            
            saveSession()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail"{
            let deviceInfoViewController = segue.destinationViewController as! UINavigationController
            let deviceInfo = deviceInfoViewController.topViewController as! DeviceInfoViewController
             if let selectedViewCell = sender as? DeviceTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedViewCell)!
                // let selectedDevice = session.devices[indexPath.row]
                let selectedDevice = sessions[sesIndex].devices[indexPath.row]
                deviceInfo.device = selectedDevice
            }
        }
        else if segue.identifier == "AddNew"{
            let nav = segue.destinationViewController as! UINavigationController
            let svc = nav.topViewController as! ViewController
            svc.lawNum = sessions[sesIndex].lawNum
            svc.notes = sessions[sesIndex].notes
            svc.city = sessions[sesIndex].city
            svc.building = sessions[sesIndex].bldg
            svc.department = sessions[sesIndex].dept
            svc.company = sessions[sesIndex].comp
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func unwindToDeviceList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? ViewController, device = sourceViewController.device{
            // Add new device
            let newIndexPath = NSIndexPath(forRow: sessions[sesIndex].devices.count, inSection: 0)
            sessions[sesIndex].devices.append(device)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
        saveSession()
    }
    
    func convertCSV(devices: [Device]) -> NSString{
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first{
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(fileName)
            
            var contentsOfFile = ""
            var i = 0
            while i < devices.count {
                let department = devices[i].department.capitalizedString
                let building = devices[i].building.capitalizedString
                let company = devices[i].company.capitalizedString
                let city = devices[i].city.capitalizedString
                let law = devices[i].law.capitalizedString
                let asset = devices[i].assetTag.capitalizedString
                let serial = devices[i].serialNum.capitalizedString
                let notes = devices[i].notes.capitalizedString
                
                contentsOfFile = contentsOfFile + department + "," + building + "," + company + ",\"" + city + "\"," + law + "," + asset + "," + serial + "," + notes + "," + law + "\n"
                i += 1
            }
            
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
            self.saveSession()
            self.dismissViewControllerAnimated(true, completion: nil)
            print("returning")
        })
        
        let submitAction = UIAlertAction(title: "Submit to Database", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.saveSession()
            self.postToServer(self)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(returnAction)
        optionMenu.addAction(submitAction)
        optionMenu.addAction(cancelAction)
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    // MARK: NSCoding
    
    func saveSession(){
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(sessions, toFile: Session.ArchiveURL.path!)
        
        if !isSuccessfulSave{
            print("Failed to save session!")
        }
        else{
            print("Session Saved!")
        }
    }
    
    func loadSession() -> Session?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Session.ArchiveURL.path!) as? Session
    }
    
    // MARK: Upload
    
    @IBAction func postToServer(sender: AnyObject) {
        print("Submitting")
        let url: NSURL = NSURL(string: "http://192.168.1.202")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let bodyData = "data=something"
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        //NSURLSession dataTaskWithRequest(request)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            (response, data, error) in
            print(response)
        }
        print(convertCSV(sessions[sesIndex].devices))
        
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
}




















