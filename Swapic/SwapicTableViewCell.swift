//
//  SwapicTableViewCell.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 5/9/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import UIKit

class SwapicTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photoImageView: UIImageView?
    @IBOutlet weak var photoTitleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
