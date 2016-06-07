//
//  LocationTableViewCell.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/6/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

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
