//
//  MapTableViewCell.swift
//  SdkSkelton
//
//  Created by MOBILE on 20/06/24.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var locationMap: MKMapView!
    var latString = ""
    var lngString = ""
    var country = ""
    var city = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        locationMap.layer.cornerRadius = 10
        locationMap.clipsToBounds = true
  
        
             
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
