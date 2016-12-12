//
//  NewPOL.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Allows for the creation of new POL Objects (POL: PO-Lawson).
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class NewPOL: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    /*
     Features of the new POL page.
     */
    
    // Connects text fields and buttons to code.
    @IBOutlet weak var lawNum: UITextField!
    @IBOutlet weak var poNum: UITextField!
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Initializes variables.
    var pols: [POL]!
    var pol: POL?
    
    // Loads the page.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's inputs
        lawNum.delegate = self
        poNum.delegate = self
        nickName.delegate = self
        // Checks text feilds and enables or disables saveButton
        checkValidEntries()
    }

    // Function from Apple to handle memory.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
    
    // Hide the keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Checks for valid entries after you finish typing in the text feilds.
    func textFieldDidEndEditing(_ textField: UITextField){
        checkValidEntries()
    }
    
    // Checks the text fields for valid data.
    func checkValidEntries(){
        let law = lawNum.text ?? ""
        let po = poNum.text ?? ""
        if (!law.isEmpty && !po.isEmpty){
            saveButton.isEnabled = true
        }
        else{
            saveButton.isEnabled = false
        }
    }
    
    // MARK: - Navigation
    
    // Creates new POL to be passed on to POLTableViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let law = lawNum.text ?? ""
        let po = poNum.text ?? ""
        let nick = nickName.text ?? ""
        // if saveButton == sender as! UIBarButtonItem!{
        if sender as AnyObject === saveButton {
            pol = POL(lawNum: law, po: po, nickname: nick, sessions: [Session]())
            pols.append(pol!)
        }
        if segue.identifier == "NewPOL"{
            let nav = segue.destination as! SessionTableViewController
            nav.pols = pols
            nav.POLIndex = pols.count - 1
            nav.newPOL = true
        }
    }
}
