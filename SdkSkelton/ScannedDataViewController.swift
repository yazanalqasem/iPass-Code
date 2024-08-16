//
//  ScannedDataViewController.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit

class ScannedDataViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var rightLogoImage: UIImageView!
    
    @IBOutlet weak var docStatusLabel: UILabel!
    @IBOutlet weak var mainHolderSection: UIView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet var livenessDataView: LivenessDataView!
    @IBOutlet var amlDataView: AmlDataView!
    @IBOutlet var socialMediaView: SocialMedia!
    @IBOutlet var metaDataView: MetaData!
    @IBOutlet var idDocDataView: DocDetailView!
    @IBOutlet weak var documentStatusView: UIView!
    @IBOutlet weak var documentStatusText: UILabel!
    
    var dataDict: [String] = ["ID Doc Check", "Liveness & Facing Similarity", "AML Watchlist", "Metadata", "Social Media"]
    
    var selectedOptionIndex = 0
    
    var overAllStatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
            
        
      
        handleUI()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func imageViewTapped() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
        
       // self.navigationController?.popViewController(animated: true)

       }
    
    func handleUI(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
               rightLogoImage.addGestureRecognizer(tapGesture)
        
        if(DataManager.shared.selectedFlowCode == 10031) {
        dataDict = ["ID Doc Check", "Liveness & Facing Similarity", "AML Watchlist", "Metadata", "Social Media"]
        }
        else if(DataManager.shared.selectedFlowCode == 10032) {
        dataDict = ["ID Doc Check", "Liveness & Facing Similarity", "AML Watchlist"]
        }
        else if(DataManager.shared.selectedFlowCode == 10015) {
        dataDict = ["ID Doc Check", "AML Watchlist"]
        }
        else {
        dataDict = ["ID Doc Check", "Liveness & Facing Similarity"]
        }
        
        sortData()
        
        documentStatusView.layer.cornerRadius = 5;
        documentStatusView.layer.masksToBounds = true;
       // optionsCollectionView.register(OptionsCell.self, forCellWithReuseIdentifier: "OptionsCell")
        optionsCollectionView.register(UINib(nibName: "OptionsCell", bundle: nil), forCellWithReuseIdentifier: "OptionsCell")

    }
    
    func sortData() {
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
            // Successfully converted JSON string to Dictionary
            
            if let data = jsonDict["data"] as? [String: Any] {
                overAllStatus = data["OverAllStatus"] as? String ?? "-"
            }
            else {
                print("Failed to convert JSON string to Dictionary")
            }
        }
        
        if(overAllStatus == "REJECTED") {
            documentStatusView.backgroundColor = UIColor(red: 249/255, green: 65/255, blue: 80/255, alpha: 1.0)
            documentStatusText.textColor = .white
        }
       else if(overAllStatus == "WARNING") {
            documentStatusView.backgroundColor = UIColor(red: 246/255, green: 153/255, blue: 49/255, alpha: 1.0)
           documentStatusText.textColor = .white
        }
        else  {
             documentStatusView.backgroundColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1.0)
            documentStatusText.textColor = .black
         }
        docStatusLabel.text = overAllStatus
        docStatusLabel.font = Fonts().getFont500(size: 10)
        
    }
    
    func addView(_ addView: UIView) {
        UIView.transition(with: self.mainHolderSection, duration: 0.6, options: .transitionCrossDissolve, animations: {
            self.mainHolderSection.addSubview(addView)
            self.viewConstraints(addView)
        })
    }
    
    // MARK: Remove View From SuperView
    func removeView(_ viewToRemove: UIView) {
        DispatchQueue.main.async {
            UIView.transition(with: self.mainHolderSection, duration: 0.3, options: .transitionCrossDissolve, animations: {
                viewToRemove.removeFromSuperview()
            })
        }
    }
    
    // MARK: Set PopUp View Constraints
    func viewConstraints(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: self.mainHolderSection.leftAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: self.mainHolderSection.rightAnchor, constant: 0).isActive = true
        view.widthAnchor.constraint(equalTo: self.mainHolderSection.widthAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: self.mainHolderSection.bottomAnchor, constant: 0).isActive = true
        view.heightAnchor.constraint(equalTo: self.mainHolderSection.heightAnchor, multiplier: 1.0, constant: 0).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        idDocDataView.initDocDetail()
      //  self.addView(idDocDataView)
       // mainHolderSection.addSubview(idDocDataView)
      //  mainHolderSection.addSubview(idDocDataView)
        
        self.addView(idDocDataView)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
//            let views = [livenessDataView, amlDataView]
//            views.forEach { vw in
//                if vw != nil {
//                    self.removeView(vw!)
//                }
//            }
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
//            self.addView(amlDataView)
//        }
    }
   
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataDict.count
    }
    

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCell", for: indexPath) as! OptionsCell
            cell.textLbl.text = dataDict[indexPath.row]
            if(indexPath.row == selectedOptionIndex) {
                cell.indicatorView.backgroundColor = UIColor(red: 126/255, green: 87/255, blue: 196/255, alpha: 1.0)
                    cell.textLbl.font = Fonts().getFont600(size: 11)
                       
            }
            else {
                cell.indicatorView.backgroundColor = UIColor.clear
                cell.textLbl.font = Fonts().getFont400(size: 11)
            }
           
           // cell.backgroundColor = .lightGray
            return cell
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedOptionIndex = indexPath.row
       
        let views = [idDocDataView, livenessDataView, amlDataView, metaDataView, socialMediaView]
//        views.forEach { vw in
//            if vw != nil {
//                if(vw == views[selectedOptionIndex]) {
//                    
//                }
//                else {
//                    self.removeView(vw!)
//                }
//               
//            }
//        }

        if(dataDict[indexPath.row] == "ID Doc Check") {
            idDocDataView.initDocDetail()
            self.addView(idDocDataView)
            
            self.removeView(livenessDataView)
            self.removeView(amlDataView)
            self.removeView(metaDataView)
            self.removeView(socialMediaView)
        }
        
       else if(dataDict[indexPath.row] == "Liveness & Facing Similarity") {
           livenessDataView.initDocDetail()
           self.addView(livenessDataView)
           
           self.removeView(idDocDataView)
           self.removeView(amlDataView)
           self.removeView(metaDataView)
           self.removeView(socialMediaView)
        }
        
        else if(dataDict[indexPath.row] == "AML Watchlist") {
            amlDataView.initDocDetail()
            self.addView(amlDataView)
            
            self.removeView(idDocDataView)
            self.removeView(livenessDataView)
            self.removeView(metaDataView)
            self.removeView(socialMediaView)
         }
        else if(dataDict[indexPath.row] == "Metadata") {
            metaDataView.initDocDetail()
            self.addView(metaDataView)
            
            self.removeView(idDocDataView)
            self.removeView(livenessDataView)
            self.removeView(amlDataView)
            self.removeView(socialMediaView)
         }
        else if(dataDict[indexPath.row] == "Social Media") {
            socialMediaView.initDocDetail()
            self.addView(socialMediaView)
            
            self.removeView(idDocDataView)
            self.removeView(livenessDataView)
            self.removeView(amlDataView)
            self.removeView(metaDataView)
         }
        
        
        
        optionsCollectionView.reloadData()
       
        
        
        
      
//        views.forEach { vw in
//            if vw != nil {
//                if(vw == amlDataView) {
//                    
//                }
//                else {
//                    self.removeView(vw!)
//                }
//               
//            }
//        }
        //self.addView(livenessDataView)
        
    }
    


        // MARK: - UICollectionViewDelegateFlowLayout

//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 100, height: 100) // Adjust the size of each cell
//        }

}

//extension UIViewController {
//    func addView(_ addView: UIView) {
//        UIView.transition(with: view, duration: 0.6, options: .transitionCrossDissolve, animations: {
//            self.view.addSubview(addView)
//            self.viewConstraints(addView)
//        })
//    }
//    
//    // MARK: Remove View From SuperView
//    func removeView(_ viewToRemove: UIView) {
//        DispatchQueue.main.async {
//            UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
//                viewToRemove.removeFromSuperview()
//            })
//        }
//    }
//    
//    // MARK: Set PopUp View Constraints
//    func viewConstraints(_ view: UIView) {
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//        view.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
//        view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
//        view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0, constant: 0).isActive = true
//    }
//}
