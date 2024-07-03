//
//  RiskIndicatorTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 17/06/24.
//

import UIKit

class RiskIndicatorTableViewCell: UITableViewCell {

    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet weak var riskStatus: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
