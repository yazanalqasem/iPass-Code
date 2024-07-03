//
//  FraudDetailTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 21/06/24.
//

import UIKit

class FraudDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var phoneRuleLabel: UILabel!
    @IBOutlet weak var emailRuleLabel: UILabel!
    @IBOutlet weak var deviceScoreLabel: UILabel!
    @IBOutlet weak var phoneClassLabel: UILabel!
    @IBOutlet weak var ipScoreLabel: UILabel!
    @IBOutlet weak var emailScoreLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var phoneRules: UILabel!
    @IBOutlet weak var emailRules: UILabel!
    @IBOutlet weak var deviceScore: UILabel!
    @IBOutlet weak var phoneClass: UILabel!
    @IBOutlet weak var ipScore: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var fraudValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headingLabel.font = Fonts().getFont400(size: 17)
        emailScoreLabel.font = Fonts().getFont600(size: 18)
        
        emailScoreLabel.font = Fonts().getFont400(size: 12)
        ipScoreLabel.font = Fonts().getFont400(size: 12)
        phoneClassLabel.font = Fonts().getFont400(size: 12)
        deviceScoreLabel.font = Fonts().getFont400(size: 12)
        emailRuleLabel.font = Fonts().getFont400(size: 12)
        phoneRuleLabel.font = Fonts().getFont400(size: 12)
        
        email.font = Fonts().getFont400(size: 13)
        ipScore.font = Fonts().getFont400(size: 13)
        phoneClass.font = Fonts().getFont400(size: 13)
        deviceScore.font = Fonts().getFont400(size: 13)
        emailRules.font = Fonts().getFont400(size: 11)
        phoneRules.font = Fonts().getFont400(size: 11)
        
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
