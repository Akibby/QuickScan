//
//  DeviceTableViewCell.swift
//  Quick Scan
//
//  Created by Austin Kibler on 5/27/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var assetLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
