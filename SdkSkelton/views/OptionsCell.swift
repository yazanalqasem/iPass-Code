//
//  OptionsCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit

class OptionsCell: UICollectionViewCell {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var textLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        indicatorView.layer.cornerRadius = 5;
        indicatorView.layer.masksToBounds = true;
    }

}
