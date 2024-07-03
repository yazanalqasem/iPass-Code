//
//  MetaData.swift
//  SdkSkelton
//
//  Created by MOBILE on 20/06/24.
//

import UIKit
import CoreLocation
import MapKit

class MetaData: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    var metaDataResults = [String: Any]()
    var allKeysArray = [String]()
    
    var latitude = ""
    var longitude = ""
    
    func initDocDetail() {
        dataTableView.register(UINib(nibName: "AmlDataTableViewCell", bundle: nil), forCellReuseIdentifier: "AmlDataTableViewCell") 
        
        dataTableView.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "MapTableViewCell")
        dataTableView.rowHeight = UITableView.automaticDimension
        dataTableView.estimatedRowHeight = 100
        dataTableView.showsVerticalScrollIndicator = false
        dataTableView.showsHorizontalScrollIndicator = false
       
        dataTableView.layer.cornerRadius = 10
        dataTableView.clipsToBounds = true
        headingLabel.font = Fonts().getFont600(size: 13)
        sortData()
    }
    
    func sortData() {
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
            // Successfully converted JSON string to Dictionary
            
            if let data = jsonDict["data"] as? [String: Any] {
                if let socialMediaData = data["socialMedia"] as? [String: Any] {
                    let ipData = socialMediaData["ip_data"] as? [String: Any]
                    let ipValues = ipData?["data"] as? [String: Any]
                    
                   
                        self.metaDataResults["Isp Name"] = ipValues?["isp_name"] ?? ""
                        self.metaDataResults["Country"] = ipValues?["country"] ?? ""
                       self.metaDataResults["map"] = ""
                        self.metaDataResults["City"] = ipValues?["city"] ?? ""
                        self.metaDataResults["Score"] = "\(String(describing: ipValues?["score"] ?? ""))"
                        self.metaDataResults["Spam Number"] = "\(String(describing: ipValues?["spam_number"] ?? ""))"
                        self.metaDataResults["State Prov"] = ipValues?["state_prov"] ?? ""
                        self.metaDataResults["TimeZone"] = ipValues?["timezone_offset"] ?? ""
                        self.metaDataResults["Type"] = ipValues?["type"]  ?? ""
                        self.metaDataResults["Harmful"] = "\(String(describing: ipValues?["harmful"] ?? ""))"
                        self.metaDataResults["Tor"] = "\(String(describing: ipValues?["tor"] ?? ""))"
                        self.metaDataResults["Vpn"] = "\(String(describing: ipValues?["vpn"] ?? ""))"
                        self.metaDataResults["Web Proxy"] = "\(String(describing: ipValues?["web_proxy"] ?? ""))"
                        self.metaDataResults["Ip Address"] = ipValues?["ip"] ?? ""
                        
                        self.latitude = "\(String(describing: ipValues?["latitude"] ?? ""))"
                        self.longitude = "\(String(describing: ipValues?["longitude"] ?? ""))"
                        
                        if let history = ipValues?["history"] as? [String: Any] {
                            self.metaDataResults["Customer Hits"] = history["customer_hits"] ?? ""
                            self.metaDataResults["Hits"] = history["hits"] ?? ""
                        }
                        else {
                            self.metaDataResults["Customer Hits"] = ""
                            self.metaDataResults["Hits"] = ""
                        }
                    
                   
               
                    
                  
                }
                
            }
           
        }
        
        allKeysArray = Array(metaDataResults.keys)
        dataTableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allKeysArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(allKeysArray[indexPath.row] == "map") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath) as! MapTableViewCell
            let latitudeString = latitude
            let longitudeString = longitude
            
            // Convert the strings to CLLocationDegrees
            if let latitude = CLLocationDegrees(latitudeString), let longitude = CLLocationDegrees(longitudeString) {
                // Create a coordinate
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                // Create an annotation
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = metaDataResults["Country"] as? String
                annotation.subtitle = metaDataResults["City"] as? String
                
                // Add the annotation to the map view
                cell.locationMap.addAnnotation(annotation)
                
                // Center the map around the annotation
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                cell.locationMap.setRegion(region, animated: true)
            } 
            

            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AmlDataTableViewCell", for: indexPath) as! AmlDataTableViewCell
        
        cell.headingLabel.text = allKeysArray[indexPath.row]
        
        if("\(String(describing: metaDataResults[allKeysArray[indexPath.row]] ?? "-"))" == "") {
            cell.valueLabel.text = "-"
        }
        else {
            cell.valueLabel.text = "\(String(describing: metaDataResults[allKeysArray[indexPath.row]] ?? "-"))"

        }
       
        return cell
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(allKeysArray[indexPath.row] == "map") {
            return 200
        }
        return UITableView.automaticDimension
    }

}
