//
//  LivenessDataView.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit

class LivenessDataView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var livenessTableView: UITableView!
    var userLivenessResults = [String: Any]()
    var faceMatchingDict = [[String: Any]]()
    
    @IBOutlet weak var headingLabel: UILabel!
    var auditImages = [String]()
   
    func initDocDetail() {
        
        livenessTableView.register(UINib(nibName: "LiveModeTableViewCell", bundle: nil), forCellReuseIdentifier: "LiveModeTableViewCell")
        livenessTableView.register(UINib(nibName: "LivenessCompareTableViewCell", bundle: nil), forCellReuseIdentifier: "LivenessCompareTableViewCell")
        livenessTableView.register(UINib(nibName: "LivenessImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "LivenessImagesTableViewCell")
        livenessTableView.rowHeight = UITableView.automaticDimension
        livenessTableView.estimatedRowHeight = 44.0
       
        livenessTableView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        livenessTableView.contentInsetAdjustmentBehavior = .never
        livenessTableView.insetsContentViewsToSafeArea = false
        if #available(iOS 15.0, *) {
            livenessTableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        livenessTableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        headingLabel.font = Fonts().getFont600(size: 13)
        sortData()
    }
    
    func sortData() {
        auditImages = [String]()
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
                 // Successfully converted JSON string to Dictionary

             if let data = jsonDict["data"] as? [String: Any],
                       let livenessDataObject = data["livenessResult"] as? [String: Any] {
                 userLivenessResults = livenessDataObject
                 
                 if let userFaceImage = userLivenessResults["faceImage"] {
                     auditImages.append(userFaceImage as! String)
                 }
                 
                 
                 if let userAuditImages = userLivenessResults["AuditImages"] as? [[String: String]]{
                     for dict in userAuditImages {
                         for value in dict.values {
                             auditImages.append(value)
                         }
                     }
                 }
                
                 sortFaceMatchingResults(basedata: data)
                 
                    } else {
                        print("Failed to extract reasons array")
                    }
            
             }
        else {
                 print("Failed to convert JSON string to Dictionary")
             }
    }
    
    func sortFaceMatchingResults(basedata : [String: Any]) {
//        faceMatchingDict
        
        var tempdataHolder = [String: Any]()
        
        if let visuFaceMatching = basedata["faceMatchngResult"] as? [[String: Any]] {
            if(visuFaceMatching.count != 0) {
                tempdataHolder["status"] = visuFaceMatching[0]["status"]
                tempdataHolder["sourceImage"] = visuFaceMatching[0]["sourceImageBase64"]
                tempdataHolder["targetImage"] = visuFaceMatching[0]["targetImageBase64"]
                tempdataHolder["faceSimilarity"] = visuFaceMatching[0]["facePercentage"]
                tempdataHolder["confidence"] = visuFaceMatching[0]["confidence"]
                tempdataHolder["source"] = "Visual"
                
                faceMatchingDict.append(tempdataHolder)
            }
           
        }
      
        tempdataHolder = [String: Any]()
        if let nfcFaceMatching = basedata["faceMatchngResultNfc"] as? [String: Any] {
            tempdataHolder["status"] = nfcFaceMatching["status"]
            tempdataHolder["sourceImage"] = nfcFaceMatching["sourceImageBase64"]
            tempdataHolder["targetImage"] = nfcFaceMatching["targetImageBase64"]
            tempdataHolder["faceSimilarity"] = nfcFaceMatching["facePercentage"]
            tempdataHolder["confidence"] = nfcFaceMatching["confidence"]
            tempdataHolder["source"] = "Nfc"
            faceMatchingDict.append(tempdataHolder)
        }
        
        
       
        livenessTableView.dataSource = self
        livenessTableView.dataSource = self
        livenessTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
       }

       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       if(indexPath.row == 0) {
           let cell = tableView.dequeueReusableCell(withIdentifier: "LiveModeTableViewCell", for: indexPath) as! LiveModeTableViewCell
           
           let anyValue: Any = userLivenessResults["Confidence"] as Any
           if let doubleValue = anyValue as? Double {
               // Step 2: Format the Double value to a String with 2 decimal places
               let formattedString = String(format: "%.2f", doubleValue)
               cell.percentLabel.text = formattedString + "%"
           } else {
               cell.percentLabel.text = "\(String(describing: userLivenessResults["Confidence"]))%"
           }
           if let sts = userLivenessResults["Status"] as? String {
               cell.statusLabel.text = sts
               
               if(sts.lowercased() == "passed") {
                   cell.livenessStatusImage.image = UIImage(named: "passedDoc")
               }
               else if(sts.lowercased() == "warning") {
                   cell.livenessStatusImage.image = UIImage(named: "warningDoc")
               }
              else {
                  cell.livenessStatusImage.image = UIImage(named: "rejectedDoc")
               }
           }
           return cell
       }
       if(indexPath.row == 1) {
           let cell = tableView.dequeueReusableCell(withIdentifier: "LivenessCompareTableViewCell", for: indexPath) as! LivenessCompareTableViewCell
           cell.faceMatchingResults = faceMatchingDict
           return cell
           
       }
     
       let cell = tableView.dequeueReusableCell(withIdentifier: "LivenessImagesTableViewCell", for: indexPath) as! LivenessImagesTableViewCell
       cell.livenessImagesArray = auditImages
       return cell
       
       }
   
   
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if(indexPath.row == 0) {
                return UITableView.automaticDimension
            }
            if(indexPath.row == 1) {
                return 298
            }
            
            let result1 = (divideAndRoundUp(auditImages.count))
            
            let widthValue =   ((self.frame.width  - 30) / 3) * 1.50
            
            
           
            
            
            let col = CGFloat(result1) * widthValue
            let col3 = col + 50
//
//            if(col3 < 100) {
//                return 100
//            }

            return CGFloat(col3)
            
            
           
        }

    func divideAndRoundUp(_ number: Int) -> Int {
        return Int(ceil(Double(number) / 3.0))
    }
    
}
