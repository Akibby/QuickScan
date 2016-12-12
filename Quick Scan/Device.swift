//
//  Device.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: The Device Object.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class Device: NSObject, NSCoding {
    
    // MARK: - Properties
    /*
     Features of the Device Object.
    */
    
    var assetTag: String
    var serialNum: String
    var photo: UIImage?
    var submit: Bool
    var time: String
    
    
    // MARK: - Archiving Paths
    /*
     Where the Device Object has its properties stored.
     */
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("devices")
    
    
    // MARK: - Types
    /*
     A structure to store the properties of the Device Object.
     */
    
    struct PropertyKey {
        static let assetTagKey = "assetTag"
        static let serialNumKey = "serialNum"
        static let photoKey = "photo"
        static let submitKey = "submit"
        static let timeKey = "time"
    }
    
    // MARK: - Initialization
    /*
     Function to create the Device Object.
     */
    
    init?(assetTag: String, serialNum: String, photo: UIImage?, submit: Bool, time: String){
        
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
    
    // MARK: - NSCoding
    /*
     Encoding, decoding, and initialization of Device Objects.
     */
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(assetTag, forKey: PropertyKey.assetTagKey)
        aCoder.encode(serialNum, forKey: PropertyKey.serialNumKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(submit, forKey: PropertyKey.submitKey)
        aCoder.encode(time, forKey: PropertyKey.timeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let assetTag = aDecoder.decodeObject(forKey: PropertyKey.assetTagKey) as! String
        let serialNum = aDecoder.decodeObject(forKey: PropertyKey.serialNumKey) as! String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        let submit = aDecoder.decodeObject(forKey: PropertyKey.submitKey) as! Bool
        let time = aDecoder.decodeObject(forKey: PropertyKey.timeKey) as! String
        
        // Must call init
        self.init(assetTag: assetTag, serialNum: serialNum, photo: photo, submit: submit, time: time)
    }
}
