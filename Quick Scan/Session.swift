//
//  Session.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/9/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class Session: NSObject {
    
    // MARK: Properties
    
    var lawNum: String
    var dept: String
    var bldg: String
    var comp: String
    var city: String
    var notes: String
    var devices = [Device]()
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("session")
    
    // MARK: Types
    
    struct PropertyKey {
        static let lawKey = "law"
        static let notesKey = "notes"
        static let cityKey = "city"
        static let buildingKey = "building"
        static let departmentKey = "department"
        static let companyKey = "company"
        static let deviceKey = "devices"
    }
    
    // MARK: Initialization
    
    init?(lawNum: String, notes: String, dept: String, bldg: String, comp: String, city: String, devices: [Device]){
        self.lawNum = lawNum
        self.notes = notes
        self.dept = dept
        self.bldg = bldg
        self.comp = comp
        self.city = city
        self.devices = devices
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(lawNum, forKey: PropertyKey.lawKey)
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        aCoder.encodeObject(city, forKey: PropertyKey.cityKey)
        aCoder.encodeObject(bldg, forKey: PropertyKey.buildingKey)
        aCoder.encodeObject(dept, forKey: PropertyKey.departmentKey)
        aCoder.encodeObject(comp, forKey: PropertyKey.companyKey)
        aCoder.encodeObject(devices, forKey: PropertyKey.deviceKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let lawNum = aDecoder.decodeObjectForKey(PropertyKey.lawKey) as! String
        let notes = aDecoder.decodeObjectForKey(PropertyKey.notesKey) as! String
        let city = aDecoder.decodeObjectForKey(PropertyKey.cityKey) as! String
        let bldg = aDecoder.decodeObjectForKey(PropertyKey.buildingKey) as! String
        let dept = aDecoder.decodeObjectForKey(PropertyKey.departmentKey) as! String
        let comp = aDecoder.decodeObjectForKey(PropertyKey.companyKey) as! String
        let devices = aDecoder.decodeObjectForKey(PropertyKey.deviceKey) as! [Device]
        
        // Must call init
        self.init(lawNum: lawNum, notes: notes, dept: dept, bldg: bldg, comp: comp, city: city, devices: (devices))
    }
}
