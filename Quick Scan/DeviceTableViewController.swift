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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleDevices()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleDevices(){
        let defaultPhoto = UIImage(named: "No Photo Selected")!
        let device1 = Device(assetTag: "1183176", serialNum: "MJ905EW", type: "PC", photo: defaultPhoto)!
        let device2 = Device(assetTag: "1156296", serialNum: "MJ96G3F", type: "PC", photo: defaultPhoto)!
        let device3 = Device(assetTag: "1155625", serialNum: "MJ75Z07", type: "PC", photo: defaultPhoto)!
        
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
            let deviceDetailViewController = segue.destinationViewController as! ViewController
             if let selectedViewCell = sender as? DeviceTableViewCell{
                let indexPath = tableView.indexPathForCell(selectedViewCell)!
                let selectedDevice = devices[indexPath.row]
                deviceDetailViewController.device = selectedDevice
            }
        }
        else if segue.identifier == "AddItem"{
            print("Adding new device")
        }
    }
    
    
    
    // MARK: Actions
    
    @IBAction func unwindToDeviceList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? ViewController, device = sourceViewController.device{
            // Add new device
            let newIndexPath = NSIndexPath(forRow: devices.count, inSection: 0)
            devices.append(device)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
}




















