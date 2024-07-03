//
//  DocAuthTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 17/06/24.
//

import UIKit

class DocAuthTableViewCell: UITableViewCell {

    @IBOutlet weak var riskDetailListView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        riskDetailListView.register(UINib(nibName: "RiskIndicatorTableViewCell", bundle: nil), forCellReuseIdentifier: "RiskIndicatorTableViewCell")
        riskDetailListView.delegate = self
        riskDetailListView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension DocAuthTableViewCell : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RiskIndicatorTableViewCell", for: indexPath) as! RiskIndicatorTableViewCell
      
        if indexPath.row == 1 {
            cell.riskLabel.text = "sfsds"
            cell.riskStatus.text = "dhfkj sdkjghdfhs gsdfkjgh kjdfhs gjkhdfkjlgh klsjdfh gjklhs dfjkgh jksdfh gkjhdfkjgh kjsdfh gjklhd fjkgh kljdfh gjkhfsghsdfh jghkjhg kdfhs gkljhsd kfjlgh kjldfh gjklhdsfkjlgh klj dhsjkhdf"
        } else {
            cell.riskLabel.text = "sfsds"
            cell.riskStatus.text = "sddsd sjhdj"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
