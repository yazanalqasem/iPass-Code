//
//  OcrHeadingTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 28/06/24.
//

import UIKit

class OcrHeadingTableViewCell: UITableViewCell {

    @IBOutlet weak var headingImage: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headingLabel.numberOfLines = 0
        headingLabel.font = Fonts().getFont400(size: 11)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
