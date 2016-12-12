//
//  SessionTableViewCell.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/9/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the cells for SessionTableViewController.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class SessionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Connects the labels on the cell to code.
    @IBOutlet weak var lawNum: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
