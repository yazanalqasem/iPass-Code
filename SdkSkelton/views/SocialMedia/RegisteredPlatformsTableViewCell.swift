//
//  RegisteredPlatformsTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 21/06/24.
//

import UIKit

class RegisteredPlatformsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var holderView: UIView!
    
    var ImagesList = ["adobe","amazon","apple","atlassian","bukalapak","disabled","discord","disneyplus","envato","evernote","facebook","flickr","github","google","gravatar","instagram","lazada","mailru","microsoft","myspace","quora","qzone","samsung","skype","spotify","tokopedia","twitter","wordpress","yahoo","skype",]
    
    @IBOutlet weak var platformLabel: UILabel!
    var platformsArray = [String]()
    var platformType = ""
    var platformImages = ["", "", "", "", ]
    
    @IBOutlet weak var platdormsCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        platdormsCollection.register(UINib(nibName: "PlatformCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlatformCollectionViewCell")
        platdormsCollection.delegate = self
        platdormsCollection.dataSource = self
        platformLabel.font = Fonts().getFont600(size: 14)
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return platformsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlatformCollectionViewCell", for: indexPath) as! PlatformCollectionViewCell
        cell.platformLabel.text = platformsArray[indexPath.row]
        
        if(ImagesList.contains(platformsArray[indexPath.row])) {
            cell.logoImage.image = UIImage(named: platformsArray[indexPath.row])
        }
        else {
            cell.logoImage.image = UIImage(named: "NA")
        }
        if(platformType == "registered") {
            cell.holderView.backgroundColor = UIColor(red: 221/255, green: 240/255, blue: 238/255, alpha: 1.0)
        }
        else {
            cell.holderView.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)

        }
      
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (collectionView.frame.width  ) / 3 , height: ((collectionView.frame.width  ) / 3) * 1.25)
        
        return CGSize(width: (collectionView.frame.width  ) / 2 , height: 60)
        
//        return CGSize(width: 100, height: 122)
    }
    
}
