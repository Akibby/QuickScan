//
//  POLTableViewCell.swift
//  Quick Scan
//
//  Created by Austin Kibler on 6/21/16.
//  Copyright © 2016 FMOLHS. All rights reserved.
//

import UIKit

class POLTableViewCell: UITableViewCell {
    
    @IBOutlet weak var POL: UILabel!
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
