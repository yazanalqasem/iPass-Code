//
//  AmlDataView.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit


class AmlHeader: UIView {
    let titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9803921569, alpha: 1)
        titleLabel.numberOfLines = 0
        // Setup the label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts().getFont600(size: 14)
        titleLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        self.addSubview(titleLabel)
        
        
        
        
        
        // Add constraints
        NSLayoutConstraint.activate([
            
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class AmlDataView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var seprator = "/*/*/*/*"
    
    @IBOutlet weak var amlDataTableView: UITableView!
    var sections = [
        Section(title: "Date of birth", items: ["MRZ", "Visual", "NFC"], isCollapsed: true),
        Section(title: "name", items: ["MRZ", "Visual", "NFC"], isCollapsed: true),
        
        Section(title: "class", items: ["MRZ" ], isCollapsed: true),
        
    ]
    
    func initDocDetail() {
        
        amlDataTableView.register(UINib(nibName: "AmlDataTableViewCell", bundle: nil), forCellReuseIdentifier: "AmlDataTableViewCell")
        amlDataTableView.rowHeight = UITableView.automaticDimension
        amlDataTableView.estimatedRowHeight = 100
        
        //   amlDataTableView.sectionHeaderHeight = UITableView.automaticDimension
        //   amlDataTableView.estimatedSectionHeaderHeight = 50
        amlDataTableView.layer.cornerRadius = 10
        amlDataTableView.clipsToBounds = true
        
        
        //amlDataTableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        amlDataTableView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        amlDataTableView.contentInsetAdjustmentBehavior = .never
        amlDataTableView.insetsContentViewsToSafeArea = false
        if #available(iOS 15.0, *) {
            amlDataTableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        sortData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
        //            self.layoutIfNeeded()
        //            self.amlDataTableView.reloadData()
        //                }
        
    }
    
    
    func sortData() {
        sections.removeAll()
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
            // Successfully converted JSON string to Dictionary
            
            if let data = jsonDict["data"] as? [String: Any],
               let amlDataObject = data["amlData"] as? [String: Any] {
                let amlContent = amlDataObject["content"] as? [String: Any]
                let amlContentData = amlContent?["data"] as? [String: Any]
                
                sections.append(
                    Section(title: "Summary", items: [
                        
                        "Account id" + seprator +  (amlDataObject["sid"] as! String)], isCollapsed: false))
                
                sections.append(
                    Section(title: "Screening", items: [
                        "Status" +  seprator + (amlDataObject["status"] as! String),
                        "Result URL" +  seprator + (amlContentData?["share_url"] as! String),
                        "Search Date" +  seprator + (amlContentData?["created_at"] as! String),
                        "Search Reference" +  seprator + (amlContentData?["ref"] as! String),
                        "Count Of Results" +  seprator + "\(String(describing: amlContentData?["total_hits"] ?? ""))",
                        "Search ID" +  seprator + "\(String(describing: amlContentData?["id"] ?? "" ))"
                        
                    ], isCollapsed: false))
                
                sections.append(
                    Section(title: "Transaction Metadata", items: [
                        
                        "Initiated At" +  seprator + (convertMetaDateString(input: amlDataObject["createdAt"] as! String) ?? amlDataObject["createdAt"] as! String),
                        "Started At" +  seprator + (convertMetaDateString(input: amlDataObject["createdAt"] as! String) ?? amlDataObject["createdAt"] as! String),
                        "Completed At" +  seprator + (convertMetaDateString(input: amlContentData?["updated_at"] as! String) ?? amlContentData?["updated_at"] as! String),
                        
                        
//                        "Started At" +  seprator + (amlDataObject["createdAt"] as! String),
                   //     "Completed At" +  seprator + (amlContentData?["updated_at"] as! String),
                        
                        
                    ], isCollapsed: false))
                
                
            }
            else {
                print("Failed to convert JSON string to Dictionary")
            }
        }
    }
    
    func convertMetaDateString(input: String) -> String? {
        // Input date format
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Output date format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Convert input string to Date object
        if let date = inputFormatter.date(from: input) {
            // Convert Date object to desired output string
            let outputString = outputFormatter.string(from: date)
            return outputString
        } else {
            // Return nil if input string could not be parsed
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return sections[section].isCollapsed ? 0 : sections[section].items.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AmlDataTableViewCell", for: indexPath) as! AmlDataTableViewCell
        
        let dataArray = separateStringByComma(sections[indexPath.section].items[indexPath.row])
        
        
        
        cell.isFromAml = true
        cell.rowValue = indexPath.row
        cell.sectionValue = indexPath.section
        
        cell.headingLabel.text = dataArray[0]
        
        if(dataArray[0] == "Result URL") {
            cell.valueLabel.text = "Open"
            cell.valueLabel.accessibilityValue = dataArray[1]
            cell.valueLabel.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
            cell.valueLabel.addGestureRecognizer(tapGesture)
            cell.valueLabel.textColor = .blue
            cell.valueLabel.font = Fonts().getFont600(size: 13)
        }
        
        else {
            cell.valueLabel.isUserInteractionEnabled = false
            cell.valueLabel.text = dataArray[1]
            cell.valueLabel.textColor = UIColor(red: 19/255, green: 26/255, blue: 41/255, alpha: 1.0)
            cell.valueLabel.font = Fonts().getFont400(size: 13)
        }
        
        return cell
    }
    
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        if let tappedLabel = sender.view as? UILabel {
                    if let customString = tappedLabel.accessibilityValue {
                        print("Label tapped with string: \(customString)")
                        if let url = URL(string: customString) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
        }
    
    func applyTopCornerRadius(to view: UIView, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
        view.setNeedsLayout()
    }
    
    func applyBottomCornerRadius(to view: UIView, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    
    func separateStringByComma(_ string: String) -> [String] {
        return string.components(separatedBy: seprator)
    }
    
    // Step 4: Implement section header view
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = AmlHeader()
            headerView.titleLabel.text =  sections[section].title
    
    
            headerView.titleLabel.numberOfLines = 0
    
    
    
    
            return headerView
      
        }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40 //UITableView.automaticDimension
    }
    
}
