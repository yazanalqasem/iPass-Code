//
//  IdVisualsCollectionViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 17/06/24.
//

import UIKit

class IdVisualsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var visualCollectionView: UICollectionView!
    
    @IBOutlet weak var holderHeight: NSLayoutConstraint!
    @IBOutlet weak var holderView: UIView!
    var docImagesList =  [String: Any]()
    var imageKeysArray =  [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sortData()
        visualCollectionView.register(UINib(nibName: "VisualCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VisualCollectionViewCell")
        visualCollectionView.delegate = self
        visualCollectionView.dataSource = self
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
       
    }
    
    func sortData() {
        
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
                 // Successfully converted JSON string to Dictionary

             if let data = jsonDict["data"] as? [String: Any],
                       let imgs = data["DocImages"] as? [String: Any] {
                      
                 docImagesList = imgs
                 imageKeysArray = Array(docImagesList.keys)
                
                 
                 
                 let result1 = (divideAndRoundUp(docImagesList.count))
                 let widthValue =   ((self.frame.width  - 30) / 3) * 1.50
                 let col = CGFloat(result1) * widthValue
                 let col3 = col + 50
                 
                 holderHeight.constant = CGFloat(col3)
                 
                 visualCollectionView.reloadData()
             } else {
                 print("Failed to extract reasons array")
             }
            
        }
        else {
            print("Failed to convert JSON string to Dictionary")
        }
    }
    func divideAndRoundUp(_ number: Int) -> Int {
        return Int(ceil(Double(number) / 3.0))
    }

}

extension IdVisualsCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageKeysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VisualCollectionViewCell", for: indexPath) as! VisualCollectionViewCell
      
        if let image = ImageConverter().convertBase64ToImage(base64String: docImagesList[imageKeysArray[indexPath.row]] as! String) {
                   // Successfully converted Base64 string to UIImage
            cell.docImage.image = image
            cell.docTitle.text = imageKeysArray[indexPath.row] 
            cell.docSubtitle.text = "Origin"
               } else {
                   print("Failed to convert Base64 string to UIImage")
               }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20 ) / 3 , height: ((collectionView.frame.width  ) / 3) * 1.25)
//        return CGSize(width: 100, height: 122)
    }
}
