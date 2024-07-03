//
//  DocAuthCollectionViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 17/06/24.
//

import UIKit

class CustomHeaderViewDocAuth: UIView {
    
    let titleHolderView = UIView()
    
    let titleLabel = UILabel()
    let arrowView = UIImageView()
    let subTitleLabel = UILabel()
    let subArrowView = UIImageView()
    
    
   
    var isOpened = Bool()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        
        
        titleHolderView.backgroundColor = .white
        self.addSubview(titleHolderView)
        
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        
        titleHolderView.addSubview(arrowView)
        
      
     
        
        titleLabel.numberOfLines = 0
        // Setup the label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts().getFont600(size: 14)
        self.addSubview(titleLabel)
        
        
        subArrowView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subArrowView)
        
        subTitleLabel.numberOfLines = 0
        // Setup the label
        subTitleLabel.backgroundColor = .white
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.font = Fonts().getFont500(size: 12)
        self.addSubview(subTitleLabel)
        subTitleLabel.text = "Risk Indicator"
        

      

     

        // Add constraints
        NSLayoutConstraint.activate([
            
            titleHolderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleHolderView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleHolderView.widthAnchor.constraint(equalToConstant: 14),
            titleHolderView.heightAnchor.constraint(equalToConstant: 14),
           
            
            
            arrowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            arrowView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowView.widthAnchor.constraint(equalToConstant: 14),
            arrowView.heightAnchor.constraint(equalToConstant: 14),
           
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            subArrowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            subArrowView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            subArrowView.widthAnchor.constraint(equalToConstant: 14),
            subArrowView.heightAnchor.constraint(equalToConstant: 14),
           
            subTitleLabel.centerYAnchor.constraint(equalTo: subArrowView.centerYAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: subArrowView.leadingAnchor,constant: 25),
          
         //   subTitleLabel.topAnchor.constraint(equalTo: subArrowImage.bottomAnchor, constant: 10), // Adding 10 points space below subArrowImage
//
            
      
//            subTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
//            subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
//            subTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         
            

            
            
           
        ])
        
      
        
       
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}




// Step 1: Define a model
struct SectionDocAuth {
    var title: String
    var items: [String]
    var isCollapsed: Bool
}

class DocAuthCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var docAuthDetailsTblView: UITableView!
    var expandedSectionHeaderNumber: Int = -1
    
    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    var sections = [
        Section(title: "", items: [], isCollapsed: false),
    ]
    var frontMapImage = ""
    var backMapImage = ""
    var frontImageSecurity = true
    var backImageSecurity = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sections.removeAll()
        docAuthDetailsTblView.separatorStyle = .none
        docAuthDetailsTblView.layoutMargins = UIEdgeInsets.zero

        docAuthDetailsTblView.tableFooterView = UIView()
        
        // Adjust content insets
        docAuthDetailsTblView.contentInset = UIEdgeInsets.zero
        docAuthDetailsTblView.scrollIndicatorInsets = UIEdgeInsets.zero
               
               // Adjust separator inset
        docAuthDetailsTblView.separatorInset = UIEdgeInsets.zero
        docAuthDetailsTblView.layoutMargins = UIEdgeInsets.zero
        
        docAuthDetailsTblView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        docAuthDetailsTblView.contentInsetAdjustmentBehavior = .never
        docAuthDetailsTblView.insetsContentViewsToSafeArea = false
        if #available(iOS 15.0, *) {
            docAuthDetailsTblView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
       // docAuthDetailsTblView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        
        docAuthDetailsTblView.register(UINib(nibName: "DocVerificationMapTableViewCell", bundle: nil), forCellReuseIdentifier: "DocVerificationMapTableViewCell")
        docAuthDetailsTblView.register(UINib(nibName: "MapImageTableViewCell", bundle: nil), forCellReuseIdentifier: "MapImageTableViewCell")
        docAuthDetailsTblView.delegate = self
        docAuthDetailsTblView.dataSource = self
        docAuthDetailsTblView.estimatedRowHeight = 200
        docAuthDetailsTblView.rowHeight = UITableView.automaticDimension
        
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
        
        sortData()
    }
    
    func sortData() {
        
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
            // Successfully converted JSON string to Dictionary
            
            if let data = jsonDict["data"] as? [String: Any] {
                let docAuth = data["DocumentAuthentication"] as? [[String: Any]]
                sortFrontImageData(docData: docAuth ?? [["": ""]] )
            }
            else {
                print("Failed to convert JSON string to Dictionary")
            }
        }
        
    }
    
    func sortFrontImageData(docData : [[String: Any]]) {
        
        if let onlyFrontData = docData[0]["Front"] as? [String: Any] {
            var frontDataValues = [String]()
            for (key, value) in onlyFrontData {
                    if key != "Map" && key != "Warning" {
                        frontDataValues.append(key + "/*/*/*/*" + "\(value)")
                    }
                if(key == "Security alert") {
                    frontImageSecurity = value as! Bool
                }
                
            }

            
            if let frontMap = onlyFrontData["Map"]  {
                frontMapImage = frontMap as! String
            }
            
            
            if(frontMapImage != "") {
                frontDataValues.append("map")
            }
            
            if let warningMessages = onlyFrontData["Warning"] as? [[String: Any]] {
                var loopCount = 1
                for message in warningMessages {
                    for (key, value) in message {
                        if let stringValue = value as? String {
                            frontDataValues.append("Warning" + String(loopCount) + "/*/*/*/*" + stringValue)
                        }
                    }
                    loopCount += 1
                }
            }
            
            if(frontDataValues.count != 0) {
                sections.append(
                    Section(
                        title: "Front Image Data", items: frontDataValues, isCollapsed: false)
                )
            }
            
            
            
           
        }
      
        sortBackImageData(docData: docData)
       
    }
    
    
    
    func sortBackImageData(docData : [[String: Any]]) {
        
        if let onlyBackData = docData[0]["Back"] as? [String: Any] {
            var backDataValues = [String]()
            for (key, value) in onlyBackData {
                    if key != "Map" && key != "Warning" {
                        backDataValues.append(key + "/*/*/*/*" + "\(value)")
                    }
                if(key == "Security alert") {
                    backImageSecurity = value as! Bool
                }
            }

            if let backMap = onlyBackData["Map"]  {
                backMapImage = backMap as! String
            }
            
           
            
            if(backMapImage != "") {
                backDataValues.append("map")
            }
            
            if let warningMessages = onlyBackData["Warning"] as? [[String: Any]] {
                var loopCount = 1
                for message in warningMessages {
                    for (key, value) in message {
                        if let stringValue = value as? String {
                            backDataValues.append("Warning" + String(loopCount) + "/*/*/*/*" + stringValue)
                        }
                    }
                    loopCount += 1
                }
            }
            
            if(backDataValues.count != 0) {
                sections.append(
                    Section(
                        title: "Back Image Data", items: backDataValues, isCollapsed: false)
                )
            }
            
            
        
        }
      
        docAuthDetailsTblView.reloadData()
       
    }
    
}
extension DocAuthCollectionViewCell : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sections[section].items.count
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].items[indexPath.row] == "map" {
           return 200
        }
        return UITableView.automaticDimension
        
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(sections[indexPath.section].items[indexPath.row] == "map") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapImageTableViewCell", for: indexPath) as! MapImageTableViewCell
            
            if let image = ImageConverter().convertBase64ToImage(base64String: sections[indexPath.section].title.contains("Front") ? frontMapImage : backMapImage) {
                // Successfully converted Base64 string to UIImage
                cell.mapImage.image = image
                cell.mapImage.layer.cornerRadius = 50
                cell.mapImage.layer.masksToBounds = true
            } else {
                print("Failed to convert Base64 string to UIImage")
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocVerificationMapTableViewCell", for: indexPath) as! DocVerificationMapTableViewCell
       
        
        let dataArray = separateStringByComma(sections[indexPath.section].items[indexPath.row])
        
        cell.titleLbl.text = dataArray[0]
    
        if(dataArray[1] == "0") {
            cell.valueLbl.text = "false"
        }
        else if(dataArray[1] == "1") {
            cell.valueLbl.text = "true"
        }
        else {
            cell.valueLbl.text = dataArray[1]
        }
        
        if(indexPath.row == 0) {
           cell.titleTop.constant = 30
            cell.subTitleTop.constant = 30
        }
        else {
            cell.titleTop.constant = 4
            cell.subTitleTop.constant = 4
        }
        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
//        cell.textLabel?.numberOfLines = 0
//        return cell
    }


    func separateStringByComma(_ string: String) -> [String] {
        return string.components(separatedBy: "/*/*/*/*")
    }

    // Step 4: Implement section header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderViewDocAuth()
        headerView.titleLabel.text = sections[section].title
        headerView.titleLabel.numberOfLines = 0
        
        
       
        
        if(sections[section].title.contains("Front")) {
            headerView.arrowView.image = frontImageSecurity == true ? UIImage(named: "red") : UIImage(named: "green")
            headerView.subArrowView.image = frontImageSecurity == true ? UIImage(named: "rejectedDoc") : UIImage(named: "passedDoc")
        }
        else {
            headerView.arrowView.image = backImageSecurity == true ? UIImage(named: "red") : UIImage(named: "green")
            headerView.subArrowView.image = backImageSecurity == true ? UIImage(named: "rejectedDoc") : UIImage(named: "passedDoc")
        }

        return headerView
    }



     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0.1
        }

func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return UITableView.automaticDimension
}


 



    
}
