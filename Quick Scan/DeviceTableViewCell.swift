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
*/

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    /*
     Features of the type table view controller.
     */
    
    // Connects the labels on the cell to code.
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
