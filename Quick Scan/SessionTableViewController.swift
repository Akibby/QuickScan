//
//  SessionTableViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/9/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Displays the array of Sessions contained within the selected POL.
    Completion Status: Complete!
    Last Update v1.0
 */

import UIKit
import MessageUI

class SessionTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    // Connects the submit button to code.
    @IBOutlet weak var submitButton: UIBarButtonItem!

    // Initializes variables.
    var pols: [POL]!
    var POLIndex: Int!
    var fileName: String! = ""
    var cursub = [Int]()
    var curdevsub = [[Int]]()
    var newPOL = false
    
    // Loads the table.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savePOLs()
        nameFile()
        
        // Checks value of needQuickUpdate() and sets the submit button to either enabled or disabled.
        if needQuickUpdate() == true{
            submitButton.isEnabled = true
        }
        else{
            submitButton.isEnabled = false
        }
    }

    
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
        return pols[POLIndex].sessions.count
    }

    // Builds the cells for the table.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ScanSessionCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SessionTableViewCell
        let session = pols[POLIndex].sessions[indexPath.row]
        let model = session.model
        let type = session.type
        let image = UIImage(named: type)
        cell.nickname.text = session.nickname
        cell.lawNum.text = model + " - " + type
        cell.photoImageView.image = image
        
        return cell
    }
    
    // Allows for deleting from the table.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pols[POLIndex].sessions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            savePOLs()
            if !needQuickUpdate(){
                submitButton.isEnabled = false
            }
        }
    }
    
    // MARK: - NSCoding
    
    // Will save the changes to the sessions array.
    func savePOLs(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pols, toFile: POL.ArchiveURL.path)
        if !isSuccessfulSave{
            print("Failed to save session!")
        }
        else{
            print("Session Saved!")
        }
    }

    // MARK: - Navigation
    
    // Prepares data to be sent to a different page.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewSession"{
            let nav = segue.destination as! NewSession
            nav.pol = pols[POLIndex]
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sessions = pols[POLIndex].sessions
        }
        else if segue.identifier == "SessionSelected"{
            let nav = segue.destination as! DeviceTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            nav.pols = pols
            nav.POLIndex = POLIndex
            nav.sesIndex = selectedIndexPath?.row
        }
    }
    
    // Handles when a page that was navigated to returns back to the table.
    @IBAction func unwindToSessionList(_ sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? DeviceTableViewController{
            if sourceViewController.newSes{
                let newIndexPath = IndexPath(row: sourceViewController.sesIndex, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .none)
            }
            if sourceViewController.needQuickUpdate(){
                pols[POLIndex].sessions[sourceViewController.sesIndex].submit = false
                submitButton.isEnabled = true
            }
            else{
                pols[POLIndex].sessions[sourceViewController.sesIndex].submit = true
                submitButton.isEnabled = false
            }
            savePOLs()
        }
    }
    
    // MARK: - Actions
    
    // Decides a file name for the csv.
    func nameFile() {
        fileName = pols[POLIndex].nickname
        if fileName == ""{
            fileName = pols[POLIndex].po
        }
        else{
            fileName = fileName + "_" + pols[POLIndex].po
        }
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
    
    // Function for the submit button.
    @IBAction func submitPressed(_ sender: AnyObject) {
        needUpdate()
        emailCSV()
    }
    
    /*
     Converts all devices in the Sessions that need submission in to their .csv format.
     Functionally complete but tweaking exact output info.
     This function DOES update the submission status of each device and session that it converts!
     */
    func convertCSV(_ sessions: [Session]) -> NSString{
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first{
            let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
            let mystring = "Device Type,Status,Asset Tag,Serial Number,Department,Building/Location,Company,City,Floor,Warranty Expiration Date,PO Number,Procure All Number,Model,Capital/Non Capital,Notes\n"
            var contentsOfFile = mystring
            var i = 0
            let pol = pols[POLIndex]
            while i < sessions.count {
                if sessions[i].submit == false{
                    let ses = pols[POLIndex].sessions[i]
                    let devs = ses.devices
                    var j = 0
                    while j < devs.count{
                        if devs[j].submit == false{
                            let dev = devs[j]
                            let asset = dev.assetTag.uppercased()
                            let serial = dev.serialNum.uppercased()
                            let department = ses.dept.uppercased()
                            let building = ses.bldg.uppercased()
                            let company = ses.comp.uppercased()
                            let city = ses.city.uppercased()
                            let law = pol.lawNum.uppercased()
                            let notes = ses.notes.uppercased()
                            let warranty = devs[j].time
                            let po = pol.po.uppercased()
                            let model = ses.model.uppercased()
                            let type = ses.type.uppercased()
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
                try contentsOfFile.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                print("File created!")
            }
            catch{
                print("Failed to create file!")
            }
            
            do {
                let readFile = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue)
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
     Iterates through all indexes of cursub and uses the values to iterate through curdevsub and find which devices were updated.
     Then changes the submission status of the devices within each submitted session and session back to false.
     */
    func unsubmit(){
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
    
    // MARK: - Email
    
    // Function to pull up the email page using the email composer defined by configuredMailComposeViewController().
    func emailCSV(){
        let emailViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.present(emailViewController, animated: true, completion: nil)
        }
    }
    
    // Configures an email view with auto filled in information.
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let contents = convertCSV(pols[POLIndex].sessions)
        let data = contents.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)
        let emailController = MFMailComposeViewController()
        let serviceEmail = "******@fmolhs.org"
        
        emailController.canResignFirstResponder
        emailController.mailComposeDelegate = self
        emailController.setToRecipients([serviceEmail])
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
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print(result)
        if result.rawValue != 2{
            unsubmit()
            controller.dismiss(animated: true, completion: nil)
        }
        else{
            controller.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "unwindToPOLList", sender: nil)
        }
        cursub = []
        curdevsub = []
    }
}
