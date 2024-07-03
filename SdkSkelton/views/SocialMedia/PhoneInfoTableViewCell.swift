//
//  PhoneInfoTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 21/06/24.
//

import UIKit

class PhoneInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var phoneCompanyLabel: UILabel!
    @IBOutlet weak var disposableLabel: UILabel!
    @IBOutlet weak var writeLabel: UILabel!
    @IBOutlet weak var possibleLabel: UILabel!
    @IBOutlet weak var validLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var phoneProgress: UIProgressView!
    @IBOutlet weak var phoneHeading: UILabel!
    @IBOutlet weak var phoneCompany: UILabel!
    @IBOutlet weak var disposable: UILabel!
    @IBOutlet weak var write: UILabel!
    @IBOutlet weak var possible: UILabel!
    @IBOutlet weak var valid: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        phoneHeading.font = Fonts().getFont400(size: 17)
        phoneNumber.font = Fonts().getFont600(size: 18)
        score.font = Fonts().getFont500(size: 15)
        
        countryLabel.font = Fonts().getFont400(size: 12)
        validLabel.font = Fonts().getFont400(size: 12)
        possibleLabel.font = Fonts().getFont400(size: 12)
        writeLabel.font = Fonts().getFont400(size: 12)
        disposableLabel.font = Fonts().getFont400(size: 12)
        phoneCompanyLabel.font = Fonts().getFont400(size: 12)
        
        country.font = Fonts().getFont400(size: 13)
        valid.font = Fonts().getFont400(size: 13)
        possible.font = Fonts().getFont400(size: 13)
        write.font = Fonts().getFont400(size: 13)
        disposable.font = Fonts().getFont400(size: 13)
        phoneCompany.font = Fonts().getFont400(size: 13)
        
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
