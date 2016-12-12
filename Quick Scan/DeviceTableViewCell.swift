//
//  DeviceTableViewCell.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the cells for DeviceTableViewController.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Connects the labels on the cell to code.
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
