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
    var photo: UIImage?
    var submit: Bool
    var time: NSDate
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("devices")
    
    // MARK: Types
    
    struct PropertyKey {
        static let assetTagKey = "assetTag"
        static let serialNumKey = "serialNum"
        static let photoKey = "photo"
        static let submitKey = "submit"
        static let timeKey = "time"
    }
    
    // MARK: Initialization
    
    init?(assetTag: String, serialNum: String, photo: UIImage?, submit: Bool, time: NSDate){
        
        // Initialize stored properties
        self.assetTag = assetTag
        self.serialNum = serialNum
        self.photo = photo
        self.submit = submit
        self.time = time
        
        super.init()
        
        if  assetTag.isEmpty || serialNum.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(assetTag, forKey: PropertyKey.assetTagKey)
        aCoder.encodeObject(serialNum, forKey: PropertyKey.serialNumKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(submit, forKey: PropertyKey.submitKey)
        aCoder.encodeObject(time, forKey: PropertyKey.timeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let assetTag = aDecoder.decodeObjectForKey(PropertyKey.assetTagKey) as! String
        let serialNum = aDecoder.decodeObjectForKey(PropertyKey.serialNumKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let submit = aDecoder.decodeObjectForKey(PropertyKey.submitKey) as! Bool
        let time = aDecoder.decodeObjectForKey(PropertyKey.timeKey) as! NSDate
        
        // Must call init
        self.init(assetTag: assetTag, serialNum: serialNum, photo: photo, submit: submit, time: time)
    }
    
    
}