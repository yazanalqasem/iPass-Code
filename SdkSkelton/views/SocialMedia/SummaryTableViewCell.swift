//
//  SummaryTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 20/06/24.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emailValue: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var userId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
//        
//        self.contentView.layer.cornerRadius = 10
//        self.contentView.clipsToBounds = true
//        
//        
//        
//        holderView.backgroundColor = .white
        
      //  self.contentView.backgroundColor = .red
        userIdLabel.font = Fonts().getFont400(size: 12)
        resultLabel.font = Fonts().getFont400(size: 12)
        emailLabel.font = Fonts().getFont400(size: 12)
        dateLabel.font = Fonts().getFont400(size: 12)
        
        userId.font = Fonts().getFont400(size: 13)
        resultValue.font = Fonts().getFont400(size: 13)
        emailValue.font = Fonts().getFont400(size: 13)
        dateValue.font = Fonts().getFont400(size: 13)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
