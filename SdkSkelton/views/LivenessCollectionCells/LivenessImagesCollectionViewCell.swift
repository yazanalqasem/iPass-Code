//
//  LivenessImagesCollectionViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 19/06/24.
//

import UIKit

class LivenessImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageName: UILabel!
    @IBOutlet weak var livenessImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageName.font = Fonts().getFont500(size: 11)
        subtitleLabel.font = Fonts().getFont400(size: 10)
        livenessImage.layer.cornerRadius = 10
        livenessImage.layer.masksToBounds = true
    }

}
