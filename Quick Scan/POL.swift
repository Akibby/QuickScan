//
//  POL.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: The POL (POL: PO-Lawson) Object.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class POL: NSObject {
    
    // MARK: - Properties
    /*
     Features of the POL Object.
     */
    
    var lawNum: String
    var po: String
    var nickname: String
    var sessions = [Session]()
    
    
    // MARK: - Archiving Paths
    /*
     Where the POL Object has its properties stored.
     */
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("pol")
    
    // MARK: - Types
    /*
     A structure to store the properties of the POL Object.
     */
    
    struct PropertyKey {
        static let lawKey = "law"
        static let poKey = "po"
        static let nicknameKey = "nickname"
        static let sessionsKey = "sessions"
    }
    
    // MARK: - Initialization
    /*
     Function to create the POL Object.
     */
    
    init?(lawNum: String, po: String, nickname: String, sessions: [Session]){
        self.lawNum = lawNum
        self.po = po
        self.nickname = nickname
        self.sessions = sessions
    }
    
    // MARK: - NSCoding
    /*
     Encoding, decoding, and initialization of POL Objects.
     */
    
    func encodeWithCoder(_ aCoder: NSCoder){
        aCoder.encode(lawNum, forKey: PropertyKey.lawKey)
        aCoder.encode(po, forKey: PropertyKey.poKey)
        aCoder.encode(nickname, forKey: PropertyKey.nicknameKey)
        aCoder.encode(sessions, forKey: PropertyKey.sessionsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let lawNum = aDecoder.decodeObject(forKey: PropertyKey.lawKey) as! String
        let po = aDecoder.decodeObject(forKey: PropertyKey.poKey) as! String
        let nickname = aDecoder.decodeObject(forKey: PropertyKey.nicknameKey) as! String
        let sessions = aDecoder.decodeObject(forKey: PropertyKey.sessionsKey) as! [Session]
        
        self.init(lawNum: lawNum, po: po, nickname: nickname, sessions: sessions)
    }
    
}
