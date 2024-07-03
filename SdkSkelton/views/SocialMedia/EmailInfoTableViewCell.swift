//
//  EmailInfoTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 21/06/24.
//

import UIKit

class EmailInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var firstBreachTextLabel: UILabel!
    @IBOutlet weak var dataBreachTextLabel: UILabel!
    @IBOutlet weak var deliveryTextLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var emailHeading: UILabel!
    @IBOutlet weak var firstBreachLabel: UILabel!
    @IBOutlet weak var dataBreachesLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var emailScore: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        emailHeading.font = Fonts().getFont400(size: 17)
        emailLabel.font = Fonts().getFont600(size: 18)
        emailScore.font = Fonts().getFont500(size: 15)
        
        deliveryTextLabel.font = Fonts().getFont400(size: 12)
        dataBreachTextLabel.font = Fonts().getFont400(size: 12)
        firstBreachTextLabel.font = Fonts().getFont400(size: 12)
        
        deliveryLabel.font = Fonts().getFont400(size: 13)
        dataBreachesLabel.font = Fonts().getFont400(size: 13)
        firstBreachLabel.font = Fonts().getFont400(size: 13)
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
    }

    @IBAction func searchClick(_ sender: Any) {
        if let url = URL(string: "https://www.google.com/search?q=" + (emailLabel.text ?? "")) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
