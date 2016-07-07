//
//  NewDevice.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Allows for the creation of a new Device object and appends it to the Device Array for the Selected Session.
 
    Completion Status: Complete!
*/

import UIKit

class NewDevice: UIViewController, UITextFieldDelegate, CaptuvoEventsProtocol {
    
    
    // MARK: - Properties
    /*
     Features of the new device page.
     */
    
    // Connects the text fields to code.
    @IBOutlet weak var assetField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    
    let formatter = NSDateFormatter()
    var lawNum: String!
    var poNum: String!
    var notes: String!
    var city: String!
    var building: String!
    var department: String!
    var company: String!
    var pols: [POL]!
    var POLIndex: Int!
    var sesIndex: Int!
    var devsAdded: Int!
    var device: Device!
    var newDevices: [Device] = []
    var isScanning = false

    // Loads the page.
    override func viewDidLoad() {
        super.viewDidLoad()
        scanButton.layer.cornerRadius = 2
        scanButton.layer.borderWidth = 1
        if Captuvo.sharedCaptuvoDevice().isDecoderRunning(){
            scanButton.enabled = true
            scanButton.layer.borderColor = scanButton.tintColor.CGColor
            batteryLabel.text = "Scanner is Ready"
        }
        else{
            scanButton.enabled = false
            scanButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
        // Handle the text field's inputs
        assetField.delegate = self
        serialField.delegate = self
        saveButton.enabled = false
        // Set format for the date.
        formatter.dateFormat = "MM/dd/yyyy"
        // Initializes the scanner.
        Captuvo.sharedCaptuvoDevice().addCaptuvoDelegate(self)
        Captuvo.sharedCaptuvoDevice().startDecoderHardware()
        
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITextFieldDelegate
    /*
     Defines how the program should react to changes in the text fields.
     */
    
    // Hide the keyboard.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Disables the save button while the serial and asset fields are empty.
    func checkValidEntries(){
        let serialText = serialField.text ?? ""
        let assetText = assetField.text ?? ""
        if !serialText.isEmpty && !assetText.isEmpty{
            saveButton.enabled = true
        }
        else{
            saveButton.enabled = false
        }
    }
    
    // Checks for a valid serial and asset tag when the text field finishes editing.
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidEntries()
    }
    
    /*
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    */
    
    // MARK: - Actions
    /*
     
     */
    
    // Saves new Device and clears feilds for next.
    @IBAction func saveDevice(sender: AnyObject) {
        let date = formatter.stringFromDate(NSDate().dateByAddingTimeInterval(60*60*24*365*3))
        let asset = assetField.text ?? ""
        let serial = serialField.text ?? ""
        let photoName = pols[POLIndex].sessions[sesIndex].type
        let photo = UIImage(named: photoName)
        if !asset.isEmpty && !serial.isEmpty{
            device = Device(assetTag: asset, serialNum: serial, photo: photo, submit: false, time: date)!
            newDevices.append(device)
            devsAdded = newDevices.count
        }
        assetField.text = ""
        serialField.text = ""
        saveButton.enabled = false
    }
    
    @IBAction func scan(sender: UIButton) {
        if isScanning{
            Captuvo.sharedCaptuvoDevice().stopDecoderScanning()
            isScanning = false
        }
        else{
            Captuvo.sharedCaptuvoDevice().startDecoderScanning()
            isScanning = true
        }
    }
    
    
    // MARK: - Navigation
    /*
     Navigation from the page.
     */
    
    // Function the cancel button calls to close the page.
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Captuvo
    /*
     Functions to for the Captuvo scanner.
     */
    
    // Starts the decoder.
    func captuvoConnected() {
        Captuvo.sharedCaptuvoDevice().startDecoderHardware()
        scanButton.enabled = true
        scanButton.layer.borderColor = scanButton.tintColor.CGColor
    }
    
    // Stops the decoder and updates label to indicate scanner is not connected.
    func captuvoDisconnected() {
        Captuvo.sharedCaptuvoDevice().stopDecoderHardware()
        batteryLabel.text = "Searching for Scanner"
        scanButton.enabled = false
        scanButton.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    // Handles data recieved from the scanner and decides which field it belongs in.
    func decoderDataReceived(data: String!) {
        isScanning = false
        if assetField.text != ""{
            serialField.text = data
            saveButton.enabled = true
        }
        else{
            assetField.text = data
        }
    }
    
    // Updates label to indicate the scanner is connected and ready.
    func decoderReady() {
        batteryLabel.text = "Scanner is Ready"
        scanButton.enabled = true
        scanButton.layer.borderColor = scanButton.tintColor.CGColor
    }
    
}