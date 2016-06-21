//
//  POL.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class POL: NSObject {
    
    // MARK: Properties
    
    var lawNum: String
    var po: String
    var nickname: String
    var sessions = [Session]()
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("pol")
    
    // MARK: Types
    
    struct PropertyKey {
        static let lawKey = "law"
        static let poKey = "po"
        static let nicknameKey = "nickname"
        static let sessionsKey = "sessions"
    }
    
    // MARK: Initialization
    
    init?(lawNum: String, po: String, nickname: String, sessions: [Session]){
        self.lawNum = lawNum
        self.po = po
        self.nickname = nickname
        self.sessions = sessions
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(lawNum, forKey: PropertyKey.lawKey)
        aCoder.encodeObject(po, forKey: PropertyKey.poKey)
        aCoder.encodeObject(nickname, forKey: PropertyKey.nicknameKey)
        aCoder.encodeObject(sessions, forKey: PropertyKey.sessionsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let lawNum = aDecoder.decodeObjectForKey(PropertyKey.lawKey) as! String
        let po = aDecoder.decodeObjectForKey(PropertyKey.poKey) as! String
        let nickname = aDecoder.decodeObjectForKey(PropertyKey.nicknameKey) as! String
        let sessions = aDecoder.decodeObjectForKey(PropertyKey.sessionsKey) as! [Session]
        
        self.init(lawNum: lawNum, po: po, nickname: nickname, sessions: sessions)
    }
    
}
