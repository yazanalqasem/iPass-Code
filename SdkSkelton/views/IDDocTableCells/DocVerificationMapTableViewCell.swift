//
//  DocVerificationMapTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 18/06/24.
//

import UIKit

class DocVerificationMapTableViewCell: UITableViewCell {

    @IBOutlet weak var subTitleBottom: NSLayoutConstraint!
    @IBOutlet weak var subTitleTop: NSLayoutConstraint!
    @IBOutlet weak var titleBottom: NSLayoutConstraint!
    @IBOutlet weak var titleTop: NSLayoutConstraint!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLbl.font = Fonts().getFont400(size: 12)
        valueLbl.font = Fonts().getFont400(size: 13)
        
        titleLbl.font = Fonts().getFont400(size: 12)
        valueLbl.font = Fonts().getFont400(size: 13)
        
        titleLbl.textColor = UIColor(red: 19/255, green: 26/255, blue: 41/255, alpha: 0.48)
        valueLbl.textColor = UIColor(red: 19/255, green: 26/255, blue: 41/255, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
