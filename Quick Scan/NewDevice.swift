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
    Last Update v1.0
*/

import UIKit

class NewDevice: UIViewController, UITextFieldDelegate, CaptuvoEventsProtocol {
    
    
    // MARK: - Properties
    
    // Connects the text fields and buttons to code.
    @IBOutlet weak var assetField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    
    // Initializes variables.
    let formatter = DateFormatter()
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
        
        // Gives scan button its border and colors it.
        scanButton.layer.cornerRadius = 10
        scanButton.layer.borderWidth = 1
        if Captuvo.sharedCaptuvoDevice().isDecoderRunning(){
            scanButton.isEnabled = true
            scanButton.layer.borderColor = scanButton.tintColor.cgColor
            batteryLabel.text = "Scanner is Ready"
        }
        else{
            scanButton.isEnabled = false
            scanButton.layer.borderColor = UIColor.lightGray.cgColor
        }
        // Handle the text field's inputs
        assetField.delegate = self
        serialField.delegate = self
        saveButton.isEnabled = false
        // Set format for the date.
        formatter.dateFormat = "MM/dd/yyyy"
        // Initializes the scanner.
        Captuvo.sharedCaptuvoDevice().addDelegate(self)
        Captuvo.sharedCaptuvoDevice().startDecoderHardware()
        
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - NSCoding
    
    // Will save the changes to the devices array.
    func savePOLs(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pols, toFile: POL.ArchiveURL.path)
        if !isSuccessfulSave{
            print("Failed to save device!")
        }
        else{
            print("Device saved!")
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    // Hide the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Disables the save button while the serial and asset fields are empty.
    func checkValidEntries(){
        let serialText = serialField.text ?? ""
        let assetText = assetField.text ?? ""
        if !serialText.isEmpty && !assetText.isEmpty{
            saveButton.isEnabled = true
        }
        else{
            saveButton.isEnabled = false
        }
    }
    
    // Checks for a valid serial and asset tag when the text field finishes editing.
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidEntries()
    }
    
    // MARK: - Actions
    
    // Saves new Device and clears feilds for next.
    @IBAction func saveDevice(_ sender: AnyObject) {
        let date = formatter.string(from: Date().addingTimeInterval(60*60*24*365*3))
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
        saveButton.isEnabled = false
        savePOLs()
    }
    
    // Called by scan button to enable and disable the Captuvo scanner.
    @IBAction func scan(_ sender: UIButton) {
        if isScanning{
            Captuvo.sharedCaptuvoDevice().stopDecoderScanning()
            isScanning = false
        }
        else{
            Captuvo.sharedCaptuvoDevice().startDecoderScanning()
            isScanning = true
        }
    }
    
    // MARK: - Captuvo
    
    // Starts the decoder updates screen to indicate scanner is connected.
    func captuvoConnected() {
        Captuvo.sharedCaptuvoDevice().startDecoderHardware()
        scanButton.isEnabled = true
        scanButton.layer.borderColor = scanButton.tintColor.cgColor
    }
    
    // Stops the decoder and updates screen to indicate scanner is not connected.
    func captuvoDisconnected() {
        Captuvo.sharedCaptuvoDevice().stopDecoderHardware()
        batteryLabel.text = "Searching for Scanner"
        scanButton.isEnabled = false
        scanButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // Updates label to indicate the scanner is connected and ready.
    func decoderReady() {
        batteryLabel.text = "Scanner is Ready"
        scanButton.isEnabled = true
        scanButton.layer.borderColor = scanButton.tintColor.cgColor
    }
    
    // Handles data recieved from the scanner and decides which field it belongs in.
    func decoderDataReceived(_ data: String!) {
        isScanning = false
        if assetField.text != ""{
            serialField.text = data
            saveButton.isEnabled = true
        }
        else{
            assetField.text = data
        }
    }
}
