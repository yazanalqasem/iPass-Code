//
//  FlowsTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit

class FlowsTableViewCell: UITableViewCell {

    @IBOutlet weak var flowImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var holderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.layer.cornerRadius = 10;
        holderView.layer.masksToBounds = true;
        // Initialization code
        let lineHeight: CGFloat = 15.0

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - subtitle.font.lineHeight

        // Create an attributed string with the paragraph style
        let attributedString = NSAttributedString(string: subtitle.text ?? "", attributes: [
            .paragraphStyle: paragraphStyle,
            .font: subtitle.font as Any
        ])

        // Assign the attributed string to the label
        subtitle.attributedText = attributedString

        // Optional: If you need the label to fit the text dynamically
        subtitle.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
