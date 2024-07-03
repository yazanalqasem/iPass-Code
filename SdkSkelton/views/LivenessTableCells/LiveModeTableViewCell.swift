//
//  LiveModeTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 19/06/24.
//

import UIKit

class LiveModeTableViewCell: UITableViewCell {

    @IBOutlet weak var livenessTextLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var livenessStatusImage: UIImageView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
        livenessTextLabel.font = Fonts().getFont500(size: 12)
        percentLabel.font = Fonts().getFont500(size: 12)
        statusLabel.font = Fonts().getFont400(size: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
