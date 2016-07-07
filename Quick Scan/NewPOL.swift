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
    
    var pol: POL?
    
    // Loads the page.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lawNum.delegate = self
        poNum.delegate = self
        nickName.delegate = self
        
        checkValidEntries()
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
    
    func textFieldDidEndEditing(textField: UITextField){
        checkValidEntries()
    }
    
    // Checks the text fields for valid data.
    func checkValidEntries(){
        let law = lawNum.text ?? ""
        let po = poNum.text ?? ""
        if (!law.isEmpty && po.characters.count >= 7){
            saveButton.enabled = true
        }
        else{
            saveButton.enabled = false
        }
    }
    
    // MARK: - Actions
    
    // Edits the PO to place two - if they are missing.
    func correctPO(po: String) -> String{
        var temp1 = po
        var temp2 = po
        var temp3 = po
        let dash = "-"
        if !po.containsString(dash){
            let suffix1 = temp1.endIndex.advancedBy(-4)..<temp1.endIndex
            let suffix2 = temp2.endIndex.advancedBy(-3)..<temp2.endIndex
            
            temp1.removeRange(suffix1)
            temp2.removeRange(suffix2)
            
            let prefix2 = temp2.startIndex..<temp2.startIndex.advancedBy(4)
            let prefix3 = temp3.startIndex..<temp3.startIndex.advancedBy(5)
            
            temp2.removeRange(prefix2)
            temp3.removeRange(prefix3)
            
            let fixedpo = temp1 + dash + temp2 + dash + temp3
            return fixedpo
        }
        else{
            return po
        }
    }
    
    // MARK: - Navigation
    /*
     Navigation from the page.
     */
    
    
    // Creates new POL to be passed on to POLTableViewController.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let law = lawNum.text ?? ""
            let po = poNum.text ?? ""
            let nick = nickName.text ?? ""
            
            pol = POL(lawNum: law, po: po, nickname: nick, sessions: [Session]())
        }
    }

}
