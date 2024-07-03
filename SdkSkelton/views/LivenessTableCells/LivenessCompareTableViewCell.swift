//
//  LivenessCompareTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 19/06/24.
//

import UIKit

class LivenessCompareTableViewCell: UITableViewCell,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var comparePageController: UIPageControl!
    @IBOutlet weak var compareCollectionView: UICollectionView!
    var faceMatchingResults = [[String: Any]]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        compareCollectionView.register(UINib(nibName: "LivenessCompareCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LivenessCompareCollectionViewCell")
        compareCollectionView.delegate = self
        compareCollectionView.dataSource = self
        comparePageController.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comparePageController.numberOfPages = faceMatchingResults.count
        return faceMatchingResults.count
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        compareCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LivenessCompareCollectionViewCell", for: indexPath) as! LivenessCompareCollectionViewCell
        
        
        var responseData = [String: Any]()
        
        responseData = faceMatchingResults[indexPath.row]
        
        if let dataSource = responseData["source"] as? String {
            cell.headerLbl.text = "Liveness - " + dataSource
        }
        
        
        let sts =  responseData["status"] as? String
        cell.statusLbl.text = sts
        if(sts?.lowercased() == "passed") {
            cell.statusImage.image = UIImage(named: "passedDoc")
        }
        else if(sts?.lowercased() == "warning") {
            cell.statusImage.image = UIImage(named: "warningDoc")
        }
        else {
            cell.statusImage.image = UIImage(named: "rejectedDoc")
        }
        
        if let src = ImageConverter().convertBase64ToImage(base64String: faceMatchingResults[indexPath.row]["sourceImage"] as! String) {
            // Successfully converted Base64 string to UIImage
            cell.sourceImage.image = src
        }
        
        if let src = ImageConverter().convertBase64ToImage(base64String: faceMatchingResults[indexPath.row]["targetImage"] as! String) {
            // Successfully converted Base64 string to UIImage
            cell.targetImage.image = src
        }
        let anyValue: Any = faceMatchingResults[indexPath.row]["faceSimilarity"] as Any
        if let doubleValue = anyValue as? Double {
            // Step 2: Format the Double value to a String with 2 decimal places
            let formattedString = String(format: "%.2f", doubleValue)
            cell.similarityPercen.text = formattedString + "%"
        } else {
            cell.similarityPercen.text = "\(String(describing: faceMatchingResults[indexPath.row]["faceSimilarity"]))%"
            print("The value is not a Double")
        }
        
        
        let stringValue: String = faceMatchingResults[indexPath.row]["confidence"] as? String ?? ""

        // Step 1: Convert String to Double
        if let doubleValue = Double(stringValue) {
            // Step 2: Format the Double to a String with 2 decimal places
            let formattedString = String(format: "%.2f", doubleValue)
            cell.confidence.text = formattedString + "%"
        } else {
            cell.similarityPercen.text = "\(String(describing: faceMatchingResults[indexPath.row]["confidence"]))%"
        }
        
       
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let pageWidth = scrollView.frame.size.width
          let fractionalPage = scrollView.contentOffset.x / pageWidth
          let page = lround(Double(fractionalPage))
       
       
        
          comparePageController.currentPage = page
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width  , height: 258 )
//        return CGSize(width: 100, height: 122)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
