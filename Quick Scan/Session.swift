//
//  Session.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/9/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: The Session Object.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class Session: NSObject {
    
    // MARK: - Properties
    /*
     Features of the Session Object.
     */
    
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
    
    // MARK: - Archiving Paths
    /*
     Where the Session Object has its properties stored.
     */
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("session")
    
    // MARK: - Types
    /*
     A structure to store the properties of the Session Object.
     */
    
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
    
    // MARK: - Initialization
    /*
     Function to create the Session Object.
     */
    
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
    
    // MARK: - NSCoding
    /*
     Encoding, decoding, and initialization of Device Objects.
     */
    
    func encodeWithCoder(_ aCoder: NSCoder) {
        aCoder.encode(notes, forKey: PropertyKey.notesKey)
        aCoder.encode(city, forKey: PropertyKey.cityKey)
        aCoder.encode(bldg, forKey: PropertyKey.buildingKey)
        aCoder.encode(dept, forKey: PropertyKey.departmentKey)
        aCoder.encode(comp, forKey: PropertyKey.companyKey)
        aCoder.encode(devices, forKey: PropertyKey.deviceKey)
        aCoder.encode(nickname, forKey: PropertyKey.nicknameKey)
        aCoder.encode(model, forKey:  PropertyKey.modelKey)
        aCoder.encode(capital, forKey: PropertyKey.capitalKey)
        aCoder.encode(type, forKey: PropertyKey.typeKey)
        aCoder.encode(submit, forKey: PropertyKey.submitKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notesKey) as! String
        let city = aDecoder.decodeObject(forKey: PropertyKey.cityKey) as! String
        let bldg = aDecoder.decodeObject(forKey: PropertyKey.buildingKey) as! String
        let dept = aDecoder.decodeObject(forKey: PropertyKey.departmentKey) as! String
        let comp = aDecoder.decodeObject(forKey: PropertyKey.companyKey) as! String
        let devices = aDecoder.decodeObject(forKey: PropertyKey.deviceKey) as! [Device]
        let nickname = aDecoder.decodeObject(forKey: PropertyKey.nicknameKey) as! String
        let model = aDecoder.decodeObject(forKey: PropertyKey.modelKey) as! String
        let capital = aDecoder.decodeObject(forKey: PropertyKey.capitalKey) as! Bool
        let type = aDecoder.decodeObject(forKey: PropertyKey.typeKey) as! String
        let submit = aDecoder.decodeObject(forKey: PropertyKey.submitKey) as! Bool
        
        // Must call init
        self.init(model: model, nickname: nickname, notes: notes, type: type, capital: capital, dept: dept, bldg: bldg, comp: comp, city: city, devices: (devices), submit: submit)
    }
}
