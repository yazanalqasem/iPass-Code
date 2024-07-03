//
//  LivenessCompareCollectionViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 19/06/24.
//

import UIKit

class LivenessCompareCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var resultConfidenceTextLabel: UILabel!
    @IBOutlet weak var faceSimTextLabel: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var confidence: UILabel!
    @IBOutlet weak var similarityPercen: UILabel!
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var sourceImage: UIImageView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
        
        targetImage.layer.cornerRadius = 10
        targetImage.layer.masksToBounds = true
        
        sourceImage.layer.cornerRadius = 10
        sourceImage.layer.masksToBounds = true
        
        headerLbl.font = Fonts().getFont600(size: 14)
        statusLbl.font = Fonts().getFont400(size: 12)
        faceSimTextLabel.font = Fonts().getFont500(size: 12)
        resultConfidenceTextLabel.font = Fonts().getFont500(size: 12)
        
        similarityPercen.font = Fonts().getFont500(size: 12)
        confidence.font = Fonts().getFont500(size: 12)
        
    }

}
