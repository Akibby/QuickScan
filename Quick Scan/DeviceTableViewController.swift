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
    
    var devices = [Device]()
    var lawNum: String!
    var notes: String!
    var city: String!
    var building: String!
    var department: String!
    var company: String!
    let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    let fileName = "sample.csv"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = lawNum
        print(lawNum)
        print(notes)
        print(city)
        print(building)
        print(department)
        print(company)
        print("")
        
        navigationItem.leftBarButtonItem = editButtonItem()
        if let savedDevices = loadDevices(){
            devices += savedDevices
        }
        
        else {
            loadSampleDevices()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleDevices(){
        let defaultPhoto = UIImage(named: "No Photo Selected")!
        let device1 = Device(assetTag: "1183176", serialNum: "MJ905EW", type: "PC", photo: defaultPhoto, law: lawNum, notes: notes, city: city, building: building, department: department, company: company)!
        let device2 = Device(assetTag: "1156296", serialNum: "MJ96G3F", type: "PC", photo: defaultPhoto, law: lawNum, notes: notes, city: city, building: building, department: department, company: company)!
        let device3 = Device(assetTag: "1155625", serialNum: "MJ75Z07", type: "PC", photo: defaultPhoto, law: lawNum, notes: notes, city: city, building: building, department: department, company: company)!
        
        devices += [device1, device2, device3]
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
        return devices.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DeviceTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DeviceTableViewCell
        
        let device = devices[indexPath.row]
        
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
            devices.removeAtIndex(indexPath.row)
            saveDevices()
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
        if segue.identifier == "ShowDetail"{
            let deviceInfoViewController = segue.destinationViewController as! UINavigationController
            let deviceInfo = deviceInfoViewController.topViewController as! DeviceInfoViewController
             if let selectedViewCell = sender as? DeviceTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedViewCell)!
                let selectedDevice = devices[indexPath.row]
                deviceInfo.device = selectedDevice
            }
        }
        else if segue.identifier == "AddNew"{
            let nav = segue.destinationViewController as! UINavigationController
            let svc = nav.topViewController as! ViewController
            svc.lawNum = lawNum
            svc.notes = notes
            svc.city = city
            svc.building = building
            svc.department = department
            svc.company = company
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func unwindToDeviceList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? ViewController, device = sourceViewController.device{
            // Add new device
            let newIndexPath = NSIndexPath(forRow: devices.count, inSection: 0)
            devices.append(device)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            print("LAW Num = \(device.law)")
        }
        saveDevices()
    }
    
    func convertCSV(devices: [Device]) -> NSString{
        if let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first{
            let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(fileName)
            
            var contentsOfFile = "Department,Building/Location,Company,City,idLawsonRequisitionNo,devAssetTag,devSerial,devNotes,idScanSession,scanTimeIn\n"
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
                
                contentsOfFile = contentsOfFile + department + "," + building + "," + company + "," + city + "," + law + "," + asset + "," + serial + "," + notes + "," + law + "\n"
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
    
    // MARK: NSCoding
    
    func saveDevices(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(devices, toFile: Device.ArchiveURL.path!)
        if !isSuccessfulSave{
            print("Failed to save devices!")
        }
    }
    
    func loadDevices() -> [Device]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Device.ArchiveURL.path!) as? [Device]
    }
    
    // MARK: Upload
    
    @IBAction func postToServer(sender: AnyObject) {
        let url: NSURL = NSURL(string: "192.168.1.202")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let bodyData = "data=something"
        request.HTTPMethod = "POST"
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){
            (response, data, error) in
            print(response)
        }
        print(convertCSV(devices))
        print("")
    }
}




















