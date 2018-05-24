/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: April 28, 2016
 ** Description: SwapicTableViewCell.swift custom cell
 *********************************************************************/


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
