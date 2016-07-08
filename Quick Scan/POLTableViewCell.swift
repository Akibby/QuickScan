//
//  POLTableViewCell.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the cells for POLTableViewController.
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class POLTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Connects the labels on the cell to code.
    @IBOutlet weak var POL: UILabel!
    @IBOutlet weak var nickname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
