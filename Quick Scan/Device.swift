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
    }
    
    // MARK: Initialization
    
    init?(assetTag: String, serialNum: String, type: String?, photo: UIImage?, law: String){
        
        // Initialize stored properties
        self.assetTag = assetTag
        self.serialNum = serialNum
        // self.type = type!
        self.photo = photo
        self.law = law
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
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let assetTag = aDecoder.decodeObjectForKey(PropertyKey.assetTagKey) as! String
        let serialNum = aDecoder.decodeObjectForKey(PropertyKey.serialNumKey) as! String
        let type = aDecoder.decodeObjectForKey(PropertyKey.typeKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let law = aDecoder.decodeObjectForKey(PropertyKey.lawKey) as! String
        
        // Must call init
        self.init(assetTag: assetTag, serialNum: serialNum, type: type, photo: photo, law: law)
    }
    
    
}