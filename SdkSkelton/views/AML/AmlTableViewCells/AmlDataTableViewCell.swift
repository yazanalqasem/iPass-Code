//
//  AmlDataTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 19/06/24.
//

import UIKit

class AmlDataTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    
    var rowValue = 0
    var sectionValue = 0
    
    var isFromAml = false
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        headingLabel.font = Fonts().getFont400(size: 12)
        valueLabel.font = Fonts().getFont400(size: 13)
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
        
        if(isFromAml == true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                if(self.sectionValue == 0 && self.rowValue == 0) {
                     self.applyAllCornerRadius(to: self.holderView, radius: 10)
                 }

                
               else if(self.sectionValue == 1 && self.rowValue == 0) {
                    self.applyTopCornerRadius(to: self.holderView, radius: 10)
                }
               else if(self.sectionValue == 1 && self.rowValue == 5) {
                   self.applyBottomCornerRadius(to: self.holderView, radius: 10)
                }

                
                            else if(self.sectionValue == 2 && self.rowValue == 0) {
                    self.applyTopCornerRadius(to: self.holderView, radius: 10)
                 }
                
                else if(self.sectionValue == 2 && self.rowValue == 2) {
                    self.applyBottomCornerRadius(to: self.holderView, radius: 10)
                 }
            }
        }
        
       
           
       }
       
       private func applyTopCornerRadius(to view: UIView, radius: CGFloat) {
           let path = UIBezierPath(
               roundedRect: view.bounds,
               byRoundingCorners: [.topLeft, .topRight],
               cornerRadii: CGSize(width: radius, height: radius)
           )
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           view.layer.mask = mask
       }
    
    private func applyAllCornerRadius(to view: UIView, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    
    private func applyBottomCornerRadius(to view: UIView, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
