//
//  NewDevice.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class NewDevice: UIViewController, UITextFieldDelegate, CaptuvoEventsProtocol {
    
    
    // MARK: Properties
    
    @IBOutlet weak var assetField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var batteryLabel: UILabel!
    var lawNum: String!
    var poNum: String!
    var notes: String!
    var city: String!
    var building: String!
    var department: String!
    var company: String!
    
    var device: Device?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's inputs
        assetField.delegate = self
        serialField.delegate = self
        saveButton.enabled = false
        
        Captuvo.sharedCaptuvoDevice().addCaptuvoDelegate(self)
        Captuvo.sharedCaptuvoDevice().startDecoderHardware()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func checkValidAsset(){
        // Disable the save button while the field is empty
        let text = assetField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func checkValidSerial(){
        // Disable the save button while the field is empty
        let text = serialField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidSerial()
        checkValidAsset()
    }
    
    /*
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    */
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let date = NSDate()
            let asset = assetField.text ?? ""
            let serial = serialField.text ?? ""
            let photo = UIImage(named: "No Photo Selected")
            
            device = Device(assetTag: asset, serialNum: serial, photo: photo, submit: false, time: date)
        }
    }
    
    // MARK: Captuvo
    
    func captuvoConnected() {
        
        Captuvo.sharedCaptuvoDevice().startDecoderHardware()
    }
    
    func captuvoDisconnected() {
        Captuvo.sharedCaptuvoDevice().stopDecoderHardware()
        batteryLabel.text = "Searching for Scanner"
    }
    
    func decoderDataReceived(data: String!) {
        if assetField.text != ""{
            serialField.text = data
            saveButton.enabled = true
        }
        else{
            assetField.text = data
        }
    }
    
    func decoderReady() {
        batteryLabel.text = "Scanner is Ready"
    }
    
}

























