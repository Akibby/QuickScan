//
//  Device.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class Device: NSObject, NSCoding {
    
    // MARK: Properties
    
    var assetTag: String
    var serialNum: String
    var type: String
    var photo: UIImage?
    var law: String
    var notes: String?
    var city: String
    var building: String
    var department: String
    var company: String
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("devices")
    
    // MARK: Types
    
    struct PropertyKey {
        static let assetTagKey = "assetTag"
        static let serialNumKey = "serialNum"
        static let typeKey = "type"
        static let photoKey = "photo"
        static let lawKey = "law"
        static let notesKey = "notes"
        static let cityKey = "city"
        static let buildingKey = "building"
        static let departmentKey = "department"
        static let companyKey = "company"
    }
    
    // MARK: Initialization
    
    init?(assetTag: String, serialNum: String, type: String?, photo: UIImage?, law: String, notes: String?, city: String, building: String, department: String, company: String){
        
        // Initialize stored properties
        self.assetTag = assetTag
        self.serialNum = serialNum
        self.photo = photo
        self.law = law
        self.notes = notes
        self.city = city
        self.building = building
        self.department = department
        self.company = company
        if type == ""{
            self.type = "Unknown"
        }
        else{
            self.type = type!
        }
        
        super.init()
        
        if  assetTag.isEmpty || serialNum.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(assetTag, forKey: PropertyKey.assetTagKey)
        aCoder.encodeObject(serialNum, forKey: PropertyKey.serialNumKey)
        aCoder.encodeObject(type, forKey: PropertyKey.typeKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(law, forKey: PropertyKey.lawKey)
        aCoder.encodeObject(notes, forKey: PropertyKey.notesKey)
        aCoder.encodeObject(city, forKey: PropertyKey.cityKey)
        aCoder.encodeObject(building, forKey: PropertyKey.buildingKey)
        aCoder.encodeObject(department, forKey: PropertyKey.departmentKey)
        aCoder.encodeObject(company, forKey: PropertyKey.companyKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let assetTag = aDecoder.decodeObjectForKey(PropertyKey.assetTagKey) as! String
        let serialNum = aDecoder.decodeObjectForKey(PropertyKey.serialNumKey) as! String
        let type = aDecoder.decodeObjectForKey(PropertyKey.typeKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let law = aDecoder.decodeObjectForKey(PropertyKey.lawKey) as! String
        let notes = aDecoder.decodeObjectForKey(PropertyKey.notesKey) as? String
        let city = aDecoder.decodeObjectForKey(PropertyKey.cityKey) as! String
        let building = aDecoder.decodeObjectForKey(PropertyKey.buildingKey) as! String
        let department = aDecoder.decodeObjectForKey(PropertyKey.departmentKey) as! String
        let company = aDecoder.decodeObjectForKey(PropertyKey.companyKey) as! String
        
        // Must call init
        self.init(assetTag: assetTag, serialNum: serialNum, type: type, photo: photo, law: law, notes: notes, city: city, building: building, department: department, company: company)
    }
    
    
}