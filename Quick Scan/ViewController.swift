//
//  ViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit
// #import "Captuvo.h"

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: Properties
    
    @IBOutlet weak var assetField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var device: Device?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's inputs
        assetField.delegate = self
        serialField.delegate = self
        typeField.delegate = self
        
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
    
    func checkValidType(){
        // Disable the save button while the field is empty
        let text = typeField.text ?? ""
        saveButton.enabled = !text.isEmpty
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
            let asset = assetField.text ?? ""
            let serial = serialField.text ?? ""
            let type = typeField.text ?? ""
            let photo = UIImage(named: "No Photo Selected")
            
            device = Device(assetTag: asset, serialNum: serial, type: type, photo: photo)
        }
    }
    
}

























