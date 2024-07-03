//
//  PlatformCollectionViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 21/06/24.
//

import UIKit

class PlatformCollectionViewCell: UICollectionViewCell  {
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var platformLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.cornerRadius = 20
        holderView.clipsToBounds = true
        platformLabel.font = Fonts().getFont400(size: 14)
    }

}
