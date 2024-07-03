//
//  DocDetailView.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit

class DocDetailView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var documentDetailsCollectionView: UICollectionView!
   
    
    func initDocDetail() {
        manageUI()
        documentDetailsCollectionView.contentInset = UIEdgeInsets.zero
        documentDetailsCollectionView.scrollIndicatorInsets = UIEdgeInsets.zero
      
        documentDetailsCollectionView.register(UINib(nibName: "DocChecksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DocChecksCollectionViewCell")
        
        documentDetailsCollectionView.register(UINib(nibName: "DocAuthCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DocAuthCollectionViewCell")
        
        documentDetailsCollectionView.register(UINib(nibName: "OcrDataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OcrDataCollectionViewCell")
        
        documentDetailsCollectionView.register(UINib(nibName: "IdVisualsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IdVisualsCollectionViewCell")
        
        documentDetailsCollectionView.delegate = self
        documentDetailsCollectionView.dataSource = self
        pageCtrl.addTarget(self, action: #selector(pageControlChanged(_:)), for: .valueChanged)

        
    }
   
    func manageUI() {
        headingLabel.font = Fonts().getFont600(size: 13)
    }

    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocChecksCollectionViewCell", for: indexPath) as! DocChecksCollectionViewCell
            return cell
        }
        
        if(indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OcrDataCollectionViewCell", for: indexPath) as! OcrDataCollectionViewCell
            return cell
        }
        
        if(indexPath.row == 2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocAuthCollectionViewCell", for: indexPath) as! DocAuthCollectionViewCell
            return cell
           
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IdVisualsCollectionViewCell", for: indexPath) as! IdVisualsCollectionViewCell
        return cell
        
       
       
    }
    

//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            if(indexPath.row == 0) {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocChecksCollectionViewCell", for: indexPath) as! DocChecksCollectionViewCell
//                return cell
//            }
//            
//            if(indexPath.row == 1) {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocAuthCollectionViewCell", for: indexPath) as! DocAuthCollectionViewCell
//                return cell
//            }
//            
//            if(indexPath.row == 2) {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IdVisualsCollectionViewCell", for: indexPath) as! IdVisualsCollectionViewCell
//                return cell
//            }
//            
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OcrDataCollectionViewCell", for: indexPath) as! OcrDataCollectionViewCell
//            
//           
//           
//            return cell
//        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let pageWidth = scrollView.frame.size.width
          let fractionalPage = scrollView.contentOffset.x / pageWidth
          let page = lround(Double(fractionalPage))
       
//        if(page == 0) {
//            headingLabel.text = "ID Document Check"
//        }
//       else if(page == 1) {
//            headingLabel.text = "Document Authentication"
//        }
//        else if(page == 2) {
//            headingLabel.text = "ID Document Visuals"
//        }
//        else {
//            headingLabel.text = "ID Document OCR"
//        }
        
        
        if(page == 0) {
            headingLabel.text = "ID Document Check"
        }
       else if(page == 1) {
            headingLabel.text = "ID Document OCR"
        }
        else if(page == 2) {
            headingLabel.text = "Document Authentication"
        }
        else {
            headingLabel.text = "ID Document Visuals"
        }
        
        
          pageCtrl.currentPage = page
      }

      @objc func pageControlChanged(_ sender: UIPageControl) {
          let indexPath = IndexPath(item: sender.currentPage, section: 0)
          documentDetailsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func divideAndRoundUp(_ number: Int) -> Int {
        return Int(ceil(Double(number) / 3.0))
    }
    
}
