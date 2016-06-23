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
*/

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var cityCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
