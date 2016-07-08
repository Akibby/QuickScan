//
//  LocationTableViewCell.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/6/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

/*
    Description: Used to create the cells for CityTableViewController, DepartmentTableViewController, and CompanyTableViewController
    Completion Status: Complete!
    Last Update v1.0
*/

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Connects the labels on the cell to code.
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var cityCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
