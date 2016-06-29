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
*/

import UIKit

class SessionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    /*
     Features of the type table view controller.
     */
    
    // Connects the labels on the cell to code.
    @IBOutlet weak var lawNum: UILabel!
    @IBOutlet weak var nickname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
