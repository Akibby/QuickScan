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
    
    var nickname: String
    var dept: String
    var bldg: String
    var comp: String
    var city: String
    var notes: String
    var model: String
    var capital: Bool
    var type: String
    var submit: Bool
    var devices = [Device]()
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("session")
    
    // MARK: Types
    
    struct PropertyKey {
        static let notesKey = "notes"
        static let cityKey = "city"
        static let buildingKey = "building"
        static let departmentKey = "department"
        static let companyKey = "company"
        static let deviceKey = "devices"
        static let nicknameKey = "nickname"
        static let modelKey = "model"
        static let capitalKey = "capital"
        static let typeKey = "type"
        static let submitKey = "submit"
    }
    
    // MARK: Initialization
    
    init?(model: String, nickname: String, notes: String, type: String, capital: Bool, dept: String, bldg: String, comp: String, city: String, devices: [Device], submit: Bool){
        self.notes = notes
        self.dept = dept
        self.bldg = bldg
        self.comp = comp
        self.city = city
        self.devices = devices
        self.nickname = nickname
        self.model = model
        self.type = type
        self.capital = capital
        self.submit = submit
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        aCoder.encodeObject(city, forKey: PropertyKey.cityKey)
        aCoder.encodeObject(bldg, forKey: PropertyKey.buildingKey)
        aCoder.encodeObject(dept, forKey: PropertyKey.departmentKey)
        aCoder.encodeObject(comp, forKey: PropertyKey.companyKey)
        aCoder.encodeObject(devices, forKey: PropertyKey.deviceKey)
        aCoder.encodeObject(nickname, forKey: PropertyKey.nicknameKey)
        aCoder.encodeObject(model, forKey:  PropertyKey.modelKey)
        aCoder.encodeObject(capital, forKey: PropertyKey.capitalKey)
        aCoder.encodeObject(type, forKey: PropertyKey.typeKey)
        aCoder.encodeObject(submit, forKey: PropertyKey.submitKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let notes = aDecoder.decodeObjectForKey(PropertyKey.notesKey) as! String
        let city = aDecoder.decodeObjectForKey(PropertyKey.cityKey) as! String
        let bldg = aDecoder.decodeObjectForKey(PropertyKey.buildingKey) as! String
        let dept = aDecoder.decodeObjectForKey(PropertyKey.departmentKey) as! String
        let comp = aDecoder.decodeObjectForKey(PropertyKey.companyKey) as! String
        let devices = aDecoder.decodeObjectForKey(PropertyKey.deviceKey) as! [Device]
        let nickname = aDecoder.decodeObjectForKey(PropertyKey.nicknameKey) as! String
        let model = aDecoder.decodeObjectForKey(PropertyKey.modelKey) as! String
        let capital = aDecoder.decodeObjectForKey(PropertyKey.capitalKey) as! Bool
        let type = aDecoder.decodeObjectForKey(PropertyKey.typeKey) as! String
        let submit = aDecoder.decodeObjectForKey(PropertyKey.submitKey) as! Bool
        
        // Must call init
        self.init(model: model, nickname: nickname, notes: notes, type: type, capital: capital, dept: dept, bldg: bldg, comp: comp, city: city, devices: (devices), submit: submit)
    }
}
