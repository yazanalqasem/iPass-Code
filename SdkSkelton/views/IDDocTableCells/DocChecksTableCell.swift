//
//  DocChecksTableCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit

class DocChecksTableCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var dataHolderView: UIView!
    
    var indexValue = 0  
    var arrayLength = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    override func layoutSubviews() {
          super.layoutSubviews()

          // Ensure the view has the correct layout
          self.dataHolderView.layoutIfNeeded()

        lblText.font = Fonts().getFont400(size: 12)
        
        if(indexValue == 0) {
            let path = UIBezierPath(
                roundedRect:  self.dataHolderView.bounds,
                byRoundingCorners: [.topLeft, .topRight],
                cornerRadii: CGSize(width: 10, height: 10) // Adjust the corner radius as needed
            )
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.dataHolderView.layer.mask = mask
        }
            
        if(indexValue == arrayLength - 1) {
            let path = UIBezierPath(
                roundedRect:  self.dataHolderView.bounds,
                byRoundingCorners: [.bottomLeft, .bottomRight],
                cornerRadii: CGSize(width: 10, height: 10) // Adjust the corner radius as needed
            )
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.dataHolderView.layer.mask = mask
        }
        
      }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
