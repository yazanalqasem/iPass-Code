//
//  OcrDataCollectionViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 14/06/24.
//

import UIKit

class CustomHeaderView: UIView {
    let titleLabel = UILabel()
    let arrowImage = UIImageView()
    let mrzvsvis = UIImageView()
    let mrzvsnfc = UIImageView()
    let overall = UIImageView()
    var isOpened = Bool()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        arrowImage.backgroundColor = .clear
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(arrowImage)
        
        mrzvsvis.backgroundColor = .green
        mrzvsvis.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mrzvsvis)
        mrzvsvis.isHidden = true
        
        mrzvsnfc.backgroundColor = .red
        mrzvsnfc.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mrzvsnfc)
        mrzvsnfc.isHidden = true
        
        overall.backgroundColor = .clear
        overall.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(overall)
        overall.isHidden = true
        
        titleLabel.numberOfLines = 0
        // Setup the label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Fonts().getFont400(size: 12)
        self.addSubview(titleLabel)
        
        let separatorHeight: CGFloat = 1.0
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        separator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separator)
        
        
        
        // Add constraints
        NSLayoutConstraint.activate([
            
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            separator.heightAnchor.constraint(equalToConstant: separatorHeight),
            
            arrowImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            arrowImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImage.widthAnchor.constraint(equalToConstant: 6),
            arrowImage.heightAnchor.constraint(equalToConstant: 10),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            
            mrzvsvis.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -55),
            mrzvsvis.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mrzvsvis.widthAnchor.constraint(equalToConstant: 15),
            mrzvsvis.heightAnchor.constraint(equalToConstant: 15),
            
            mrzvsnfc.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            mrzvsnfc.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mrzvsnfc.widthAnchor.constraint(equalToConstant: 15),
            mrzvsnfc.heightAnchor.constraint(equalToConstant: 15),
            
            overall.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            overall.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            overall.widthAnchor.constraint(equalToConstant: 15),
            overall.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}




// Step 1: Define a model
struct Section {
    var title: String
    var items: [String]
    var isCollapsed: Bool
}

class OcrDataCollectionViewCell: UICollectionViewCell , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var holderView: UIView!
    var expandedSections = Set<Int>()
    var seprator = "/*/*/*/*"
    var expandedSectionHeaderNumber: Int = -1
    
    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    var sections = [
        Section(title: "Date of birth", items: ["MRZ", "Visual", "NFC"], isCollapsed: true),
        Section(title: "name", items: ["MRZ", "Visual", "NFC"], isCollapsed: true),
        
        Section(title: "class", items: ["MRZ" ], isCollapsed: true),
        
    ]
    
    @IBOutlet weak var ocrDataTableView: UITableView!
    var visualData = [String: Any]()
    var mrzData = [String: Any]()
    var nfcData = [String: Any]()
    var mrzVisData = [String: Any]()
    var mrzNfcData = [String: Any]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //  ocrDataTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        sections.removeAll()
        ocrDataTableView.register(UINib(nibName: "OcrSubheadingCell", bundle: nil), forCellReuseIdentifier: "OcrSubheadingCell")
        ocrDataTableView.register(UINib(nibName: "OcrHeadingTableViewCell", bundle: nil), forCellReuseIdentifier: "OcrHeadingTableViewCell")
        
        
        //        ocrDataTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //        ocrDataTableView.rowHeight = UITableView.automaticDimension
        //        ocrDataTableView.estimatedRowHeight = 100
        //
        //        ocrDataTableView.sectionHeaderHeight = UITableView.automaticDimension
        //        ocrDataTableView.estimatedSectionHeaderHeight = 50
        //        ocrDataTableView.layer.cornerRadius = 10
        //        ocrDataTableView.clipsToBounds = true
        
        ocrDataTableView.estimatedRowHeight = 44.0
        ocrDataTableView.rowHeight = UITableView.automaticDimension
        ocrDataTableView.delegate = self
        ocrDataTableView.dataSource = self
        
        
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        sortData()
    }
    
    
    
    func sortData() {
        
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
            // Successfully converted JSON string to Dictionary
            
            if let data = jsonDict["data"] as? [String: Any] {
                let docDetails = data["DocDetails"] as? [String: Any] ?? ["" :""]
                
                seprateDataValues(dataVal: docDetails)
            }
            else {
                print("Failed to convert JSON string to Dictionary")
            }
        }
        
    }
    
    func seprateDataValues(dataVal : [String: Any]) {
        if let mrzValues = dataVal["MRZ"] as? [String: Any] {
            mrzData = mrzValues
        }
        if let visValues = dataVal["Visual"] as? [String: Any] {
            visualData = visValues
        }
        if let nfcValues = dataVal["NFC"] as? [String: Any] {
            nfcData = nfcValues
        }
        if let mrzVisValues = dataVal["MRZ_VIZ_Comparison"] as? [String: Any] {
            mrzVisData = mrzVisValues
        }
        if let mrzNfcValues = dataVal["MRZ_NFC_Comparison"] as? [String: Any] {
            mrzNfcData = mrzNfcValues
        }
        
        var allKeysData = [String]()
        allKeysData.append(contentsOf: Array(mrzData.keys))
        allKeysData.append(contentsOf: Array(visualData.keys))
        allKeysData.append(contentsOf: Array(nfcData.keys))
        allKeysData.append(contentsOf: Array(mrzVisData.keys))
        allKeysData.append(contentsOf: Array(mrzNfcData.keys))
        allKeysData = Array(Set(allKeysData))
        
        sections.removeAll()
        
        var tempArray = [String]()
        
        for currentKey in allKeysData {
            tempArray.removeAll()
            if let mrz = mrzData[currentKey] as? String {
                tempArray.append(currentKey + seprator + "MRZ" + seprator + mrz + seprator + "normal")
            }
            
            if let vis = visualData[currentKey] as? String {
                tempArray.append(currentKey + seprator + "Visual" + seprator + vis + seprator + "normal")
            }
            
            if let nfc = nfcData[currentKey] as? String {
                tempArray.append(currentKey + seprator + "NFC-DATA" + seprator + nfc + seprator + "normal")
            }
            
            if let mrVs = mrzVisData[currentKey] as? String {
                tempArray.append(currentKey + seprator + "MRZ-Viz" + seprator + mrVs + seprator + "compare")
            }
            
            if let mrNfc = mrzNfcData[currentKey] as? String {
                tempArray.append(currentKey + seprator + "MRZ-NFC" + seprator + mrNfc + seprator + "compare")
            }
            
            sections.append(
                Section(title: currentKey, items: tempArray, isCollapsed: true)
            )
            
        }
        
        
        ocrDataTableView.reloadData()
        
        
        
        
    }
    
    func separateStringByComma(_ string: String) -> [String] {
        let components = string.components(separatedBy: seprator)
        return components.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        if !section.isCollapsed {
            return section.items.count + 1
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OcrHeadingTableViewCell", for: indexPath) as! OcrHeadingTableViewCell
                cell.headingLabel.text = sections[indexPath.section].title 
                
                if(sections[indexPath.section].isCollapsed == true) {
                    cell.headingImage.image = UIImage(named: "close")
                }
                else {
                    cell.headingImage.image = UIImage(named: "open")
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OcrSubheadingCell", for: indexPath) as! OcrSubheadingCell
                //cell.label.text = sections[indexPath.section].expandableCellOptions[indexPath.row - 1]
                let completeData = separateStringByComma(sections[indexPath.section].items[indexPath.row - 1])
                
                if(completeData[3] == "normal") {
                    cell.titleLabel.text = completeData[1]
                    cell.valueLabel.text = completeData[2]
                    cell.statusImage.isHidden = true
                    cell.valueLabel.isHidden = false
                }
                if(completeData[3] == "compare") {
                    cell.titleLabel.text = completeData[1]
                    cell.statusImage.isHidden = false
                    cell.valueLabel.isHidden = true
                    if(completeData[2].lowercased() == "true") {
                        cell.statusImage.image = UIImage(named: "pas")
                    }
                    else {
                        cell.statusImage.image = UIImage(named: "fail")
                    }
                }
                return cell
            }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            sections[indexPath.section].isCollapsed = !sections[indexPath.section].isCollapsed
            tableView.reloadData()
        }

    }
  
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    
    
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        
//        
//        return sections[section].isCollapsed ? 0 : sections[section].items.count
//    }
//    
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "OcrSubheadingCell", for: indexPath) as! OcrSubheadingCell
//        
//        let completeData = separateStringByComma(sections[indexPath.section].items[indexPath.row])
//        
//        if(completeData[3] == "normal") {
//            cell.titleLabel.text = completeData[1]
//            cell.valueLabel.text = completeData[2]
//            cell.statusImage.isHidden = true
//            cell.valueLabel.isHidden = false
//        }
//        if(completeData[3] == "compare") {
//            cell.titleLabel.text = completeData[1]
//            cell.statusImage.isHidden = false
//            cell.valueLabel.isHidden = true
//            if(completeData[2].lowercased() == "true") {
//                cell.statusImage.image = UIImage(named: "pas")
//            }
//            else {
//                cell.statusImage.image = UIImage(named: "fail")
//            }
//        }
//    
//        return cell
//        
//        
//    }
//    
//    
//    
//    
//    // Step 4: Implement section header view
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = CustomHeaderView()
//        headerView.titleLabel.text =  sections[section].title
//        
//        
//        headerView.titleLabel.numberOfLines = 0
//        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleHeaderTap(_:)))
//        headerView.addGestureRecognizer(tapGestureRecognizer)
//        headerView.tag = section // Use the section as the tag
//        
//        
//        
//        
//        
//        let result = sections[section].items.joined(separator: " ")
//        if(result.contains("false") || result.contains("False")) {
//            headerView.overall.image = UIImage(named: "rejectedDoc")
//        }
//        else {
//            headerView.overall.image = UIImage(named: "passedDoc")
//        }
//        
//        if(sections[section].isCollapsed == true) {
//            headerView.arrowImage.image = UIImage(named: "close")
//        }
//        else {
//            headerView.arrowImage.image = UIImage(named: "open")
//        }
//        
//        
//        return headerView
//    }
//    
//    
//    
//    
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    
//    
//    
//    
//    // Step 5: Handle header tap to collapse/expand
//    @objc func handleHeaderTap(_ sender: UITapGestureRecognizer) {
//        //        ocrDataTableView.beginUpdates()
//        //        guard let section = sender.view?.tag else { return }
//        //
//        //        sections[section].isCollapsed.toggle() // Toggle collapse/expand
//        //        let contentOffset = ocrDataTableView.contentOffset
//        //        // Reload the section with animation
//        //
//        //
//        //        DispatchQueue.main.async {
//        //            self.adjustTableViewOffsetIfNeeded(section: section)
//        //        }
//        //        ocrDataTableView.reloadSections(IndexSet(integer: section), with: .none)
//        //        ocrDataTableView.endUpdates()
//        //
//        
//        guard let section = sender.view?.tag else { return }
//        
//        // Save the current content offset
//        let oldContentOffset = ocrDataTableView.contentOffset
//        
//        // Get the first visible index path
//        let firstVisibleIndexPath = ocrDataTableView.indexPathsForVisibleRows?.first
//        
//        // Toggle collapse/expand
//        sections[section].isCollapsed.toggle()
//        
//        // Perform the updates
//        ocrDataTableView.beginUpdates()
//        ocrDataTableView.reloadSections(IndexSet(integer: section), with: .none)
//        ocrDataTableView.endUpdates()
//        
//        // Check if the section still has rows after collapsing
//        let numberOfRowsInSection = ocrDataTableView.numberOfRows(inSection: section)
//        if numberOfRowsInSection > 0, let firstVisibleIndexPath = firstVisibleIndexPath {
//            // Ensure the index path is within bounds
//            let safeIndexPath = IndexPath(row: min(firstVisibleIndexPath.row, numberOfRowsInSection - 1), section: firstVisibleIndexPath.section)
//            
//            // Scroll to the safe index path
//            ocrDataTableView.scrollToRow(at: safeIndexPath, at: .top, animated: false)
//            
//            // Adjust the content offset if necessary
//            ocrDataTableView.setContentOffset(oldContentOffset, animated: false)
//        } else {
//            // Fallback: Set the content offset directly if no visible rows are found
//            ocrDataTableView.setContentOffset(oldContentOffset, animated: false)
//        }
//        
//        
//    }
//    
//    
//    private func adjustTableViewOffsetIfNeeded(section: Int) {
//        let rect = ocrDataTableView.rectForHeader(inSection: section)
//        let currentOffset = ocrDataTableView.contentOffset
//        
//        if rect.origin.y < currentOffset.y {
//            // Section header is above current content offset
//            ocrDataTableView.setContentOffset(CGPoint(x: currentOffset.x, y: rect.origin.y), animated: true)
//        } else {
//            let bottomY = rect.origin.y + rect.size.height
//            let tableHeight = ocrDataTableView.frame.size.height
//            if bottomY > currentOffset.y + tableHeight {
//                // Section header is below current content offset
//                ocrDataTableView.setContentOffset(CGPoint(x: currentOffset.x, y: rect.origin.y + rect.size.height - tableHeight), animated: true)
//            }
//        }
//    }
    
}

