//
//  DomainDetailTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 24/06/24.
//

import UIKit

class DomainDetailTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var headingTitle: UILabel!
    @IBOutlet weak var domainsTableView: UITableView!
    var domainsData = [[String : Any]]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headingTitle.font = Fonts().getFont400(size: 17)
        
        domainsTableView.register(UINib(nibName: "DocVerificationMapTableViewCell", bundle: nil), forCellReuseIdentifier: "DocVerificationMapTableViewCell")
        holderView.layer.cornerRadius = 10
        holderView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domainsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocVerificationMapTableViewCell", for: indexPath) as! DocVerificationMapTableViewCell
        
        // Get the dictionary for the current row
             let domainDetails = domainsData[indexPath.row]
             
             // Extract a single key-value pair (assuming each dictionary has only one pair)
             if let (key, value) = domainDetails.first {
                 cell.titleLbl.text = key
                 cell.valueLbl.text = "\(value)"
              
             }
     
        return cell
    }
    
}
