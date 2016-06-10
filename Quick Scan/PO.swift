//
//  PO.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/3/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class PO: NSObject {
    
    // MARK: Properties
    
    var poNum: String
    var lawNum: String
    var dept: String
    var bldg: String
    var comp: String
    var city: String
    var devices = [Device]()
    
    // MARK: Initialization
    
    init?(poNum: String, lawNum: String, dept: String, bldg: String, comp: String, city: String, devices: [Device]) {
        self.poNum = poNum
        self.lawNum = lawNum
        self.dept = dept
        self.bldg = bldg
        self.comp = comp
        self.city = city
        self.devices = devices
    }
}
