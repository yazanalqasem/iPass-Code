//
//  VisualCollectionViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 17/06/24.
//

import UIKit

class VisualCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var docSubtitle: UILabel!
    @IBOutlet weak var docTitle: UILabel!
    @IBOutlet weak var docImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        docTitle.font = Fonts().getFont500(size: 11)
        docSubtitle.font = Fonts().getFont400(size: 10)
        docImage.layer.cornerRadius = 10
        docImage.layer.masksToBounds = true
    }

}
