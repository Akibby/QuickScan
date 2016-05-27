//
//  Device.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class Device: NSObject {
    
    // MARK: Properties
    
    var assetTag: String
    var serialNum: String
    var type: String
    
    
    // MARK: Initialization
    
    init?(assetTag: String, serialNum: String, type: String){
        
        // Initialize stored properties
        self.assetTag = assetTag
        self.serialNum = serialNum
        self.type = type
        
        super.init()
        
        if  assetTag.isEmpty || serialNum.isEmpty || type.isEmpty{
            return nil
        }
    }
}