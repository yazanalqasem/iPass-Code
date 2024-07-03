//
//  LivenessImagesTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 19/06/24.
//

import UIKit

class LivenessImagesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var livenessDataCollection: UICollectionView!
    var livenessImagesArray =  [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        livenessDataCollection.register(UINib(nibName: "LivenessImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LivenessImagesCollectionViewCell")
        livenessDataCollection.delegate = self
        livenessDataCollection.dataSource = self
        
        headingLabel.font = Fonts().getFont600(size: 14)
        
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return livenessImagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LivenessImagesCollectionViewCell", for: indexPath) as! LivenessImagesCollectionViewCell
        
      
        if let src = ImageConverter().convertBase64ToImage(base64String: livenessImagesArray[indexPath.row]) {
            // Successfully converted Base64 string to UIImage
            cell.livenessImage.image = src
        }
        if(indexPath.row == 0) {
            cell.imageName.text = "Selfie"
        }
        else {
            cell.imageName.text = "Liveness " + "\(indexPath.row )"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20) / 3 , height: ((collectionView.frame.width  ) / 3) * 1.50)
//        return CGSize(width: 100, height: 122)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
