//
//  NewPOLViewController.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class NewPOLViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var lawNum: UITextField!
    @IBOutlet weak var poNum: UITextField!
    @IBOutlet weak var nickName: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var pol: POL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lawNum.delegate = self
        poNum.delegate = self
        nickName.delegate = self
        
        checkValidEntries()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField){
        checkValidEntries()
    }
    
    func checkValidEntries(){
        let law = lawNum.text ?? ""
        let po = poNum.text ?? ""
        if (!law.isEmpty && po.characters.count > 7){
            saveButton.enabled = true
        }
        else{
            saveButton.enabled = false
        }
    }
    
    // MARK: - Actions
    
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
            print(fixedpo)
            return fixedpo
        }
        else{
            return po
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let law = lawNum.text ?? ""
            let po = correctPO(poNum.text!)
            let nick = nickName.text ?? ""
            
            pol = POL(lawNum: law, po: po, nickname: nick, sessions: [Session]())
        }
    }

}
