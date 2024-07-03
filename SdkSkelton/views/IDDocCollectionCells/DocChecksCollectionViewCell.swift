//
//  DocChecksCollectionViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit

class DocChecksCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var emptyDataLabel: UILabel!
    @IBOutlet weak var checksTableView: UITableView!
    
    var reasonsDataArray =  [[String: Any]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sortData()
        checksTableView.rowHeight = UITableView.automaticDimension
        checksTableView.estimatedRowHeight = 44.0
        checksTableView.contentInset = UIEdgeInsets.zero
        checksTableView.scrollIndicatorInsets = UIEdgeInsets.zero
        checksTableView.register(UINib(nibName: "DocChecksTableCell", bundle: nil), forCellReuseIdentifier: "DocChecksTableCell")
        
        emptyDataLabel.font = Fonts().getFont500(size: 14)
        
      
        
    }
    
    func sortData() {
        
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
                 // Successfully converted JSON string to Dictionary

             if let data = jsonDict["data"] as? [String: Any],
                       let reasons = data["Reason"] as? [[String: Any]] {
                 reasonsDataArray = reasons
                 checksTableView.reloadData()
                 
                 if(reasonsDataArray.count == 0) {
                     emptyDataLabel.isHidden = false
                 }
                 else {
                     emptyDataLabel.isHidden = true
                 }
                 
                    } else {
                        print("Failed to extract reasons array")
                    }
            
             } 
        else {
                 print("Failed to convert JSON string to Dictionary")
             }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasonsDataArray.count
       }

       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "DocChecksTableCell", for: indexPath) as! DocChecksTableCell
       
       let reason = reasonsDataArray[indexPath.row]
              if let text = reason["Text"] as? String {
                  cell.lblText?.text = text
                  
                  
                  
                  if let status = reason["Status"] as? String {
                      if(status.lowercased() == "passed") {
                          cell.statusImage.image = UIImage(named: "passedDoc")
                      }
                     else if(status.lowercased() == "warning") {
                         cell.statusImage.image = UIImage(named: "warningDoc")
                      }
                     else {
                         cell.statusImage.image = UIImage(named: "rejectedDoc")
                      }
                  }
                  
              }
   
       cell.indexValue = indexPath.row
       cell.arrayLength = reasonsDataArray.count
     
     

           return cell
       }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    
}
