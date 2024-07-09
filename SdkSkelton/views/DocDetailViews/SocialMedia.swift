//
//  SocialMedia.swift
//  SdkSkelton
//
//  Created by MOBILE on 20/06/24.
//

import UIKit

class SocialMedia: UIView, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var socalDataTableView: UITableView!
  
    var emailRules = ""
    var phoneRules = ""
    
    func initDocDetail() {
        socalDataTableView.register(UINib(nibName: "SummaryTableViewCell", bundle: nil), forCellReuseIdentifier: "SummaryTableViewCell")
        socalDataTableView.register(UINib(nibName: "FraudDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FraudDetailTableViewCell")
        socalDataTableView.register(UINib(nibName: "PhoneInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhoneInfoTableViewCell")
        socalDataTableView.register(UINib(nibName: "EmailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "EmailInfoTableViewCell") 
        socalDataTableView.register(UINib(nibName: "RegisteredPlatformsTableViewCell", bundle: nil), forCellReuseIdentifier: "RegisteredPlatformsTableViewCell")
        socalDataTableView.register(UINib(nibName: "DomainDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DomainDetailTableViewCell")
        socalDataTableView.rowHeight = UITableView.automaticDimension
        socalDataTableView.estimatedRowHeight = 100
        socalDataTableView.showsVerticalScrollIndicator = false
        socalDataTableView.showsHorizontalScrollIndicator = false
       
        socalDataTableView.layer.cornerRadius = 10
        socalDataTableView.clipsToBounds = true
        
        topLabel.font = Fonts().getFont600(size: 13)
        topLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        
        sortData()
    }
    
    var completeEmailData = [String: Any]()
    var emailDataObject = [String: Any]() 
    var emailBreachDetails = [String: Any]()
    var domainDetails = [String: Any]()
    var completePhoneData = [String: Any]()
    var completeIpData = [String: Any]()
    var ipDataObject = [String: Any]()
    var phoneRegisteredPlatforms = [String]()
    var emailRegisteredPlatforms = [String]()
    var emailUnRegisteredPlatforms = [String]()
    var phoneUnRegisteredPlatforms = [String]()
    var domainDetailsArray = [[String : Any]]()
    
    func sortData() {
        if let jsonDict = JsonDataHandlerClass().getJsonParserdData() {
            // Successfully converted JSON string to Dictionary
            
            if let data = jsonDict["data"] as? [String: Any],
               let socialMediaObject = data["socialMedia"] as? [String: Any] {
                completeEmailData = socialMediaObject["email_data"] as? [String: Any] ?? ["" : ""]
                emailDataObject = completeEmailData["data"] as? [String: Any] ?? ["" : ""]
                
                emailBreachDetails = emailDataObject["breach_details"] as? [String: Any] ?? ["" : ""] 
                domainDetails = emailDataObject["domain_details"] as? [String: Any] ?? ["" : ""]
                
                
                var domainKeys = [String]()
                domainKeys = Array(domainDetails.keys)
                
                var tempDomainDict = [String: Any]()
                for key in domainKeys {
                    tempDomainDict = [String: Any]()
                   tempDomainDict[key] = domainDetails[key]
                    domainDetailsArray.append(tempDomainDict)
                }

                
                
                
                completePhoneData = socialMediaObject["phone_data"] as? [String: Any] ?? ["" : ""]
                completeIpData = socialMediaObject["ip_data"] as? [String: Any] ?? ["" :""]
                ipDataObject = completeIpData["data"] as? [String: Any] ?? ["" :""]
                
                
                let appliedEmailRules = emailDataObject["applied_rules"] as? [[String: Any]]
                let appliedPhoneRules = completePhoneData["applied_rules"] as? [[String: Any]]
                
                emailRules = ""
                for i in (0 ..< (appliedEmailRules?.count ?? 0)) {
                       var tempStr = ""
                    tempStr = tempStr + (appliedEmailRules?[i]["id"] as! String) +
                    " " + (appliedEmailRules?[i]["name"] as! String) + " " +
                    (appliedEmailRules?[i]["operation"] as! String) + " " +
                    ("\(appliedEmailRules?[i]["score"] ?? "")") + "\n"
                    emailRules.append(tempStr)
                }
                
                
                phoneRules = ""
                
                for i in (0 ..< (appliedPhoneRules?.count ?? 0)) {
                       var tempStr = ""
                    tempStr = tempStr + (appliedPhoneRules?[i]["id"] as! String) +
                    " " + (appliedPhoneRules?[i]["name"] as! String) + " " +
                    (appliedPhoneRules?[i]["operation"] as! String) + " " +
                    ("\(appliedPhoneRules?[i]["score"] ?? "")") + "\n"
                    phoneRules.append(tempStr)
                }
                
                let phonePlatforms = completePhoneData["account_details"] as? [String: Any]  
                let emailPlatforms = emailDataObject["account_details"] as? [String: Any]
                
                var tempPhoneKeys = [String]()
                tempPhoneKeys =  Array(phonePlatforms!.keys )
                
                var tempEmailKeys = [String]()
                tempEmailKeys =  Array(emailPlatforms!.keys )
                
                phoneRegisteredPlatforms.removeAll()
                phoneUnRegisteredPlatforms.removeAll()
                
                for i in (0 ..< (tempPhoneKeys.count)) {
                    var tempObj = [String : Any]()
                    
                    tempObj = phonePlatforms?[tempPhoneKeys[i]] as! [String : Any]
                    
                    if let registered = tempObj["registered"] as? Bool {
                            if registered == true {
                                phoneRegisteredPlatforms.append(tempPhoneKeys[i])
                            } 
                           else {
                                phoneUnRegisteredPlatforms.append(tempPhoneKeys[i])
                            }
                        }
                    else {
                        phoneUnRegisteredPlatforms.append(tempPhoneKeys[i])
                    }
                    
                }
                
                
                emailRegisteredPlatforms.removeAll()
                emailUnRegisteredPlatforms.removeAll()
                for i in (0 ..< (tempEmailKeys.count)) {
                    var tempObj = [String : Any]()
                    
                    tempObj = emailPlatforms?[tempEmailKeys[i]] as! [String : Any]
                    
                    if let registered = tempObj["registered"] as? Bool {
                            if registered == true {
                                emailRegisteredPlatforms.append(tempEmailKeys[i])
                            }
                           else {
                               emailUnRegisteredPlatforms.append(tempEmailKeys[i])
                            }
                        }
                    else {
                        emailUnRegisteredPlatforms.append(tempEmailKeys[i])
                    }
                    
                }
              
            }
            else {
                print("Failed to convert JSON string to Dictionary")
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            cell.userId.text = completeEmailData["_id"] as? String
            cell.emailValue.text = emailDataObject["email"] as? String
            cell.resultValue.text =  "\(String(describing: emailDataObject["score"] ?? "-"))"
            
            let dateString = completeEmailData["update_at"] as? String ?? ""

            // Create a DateFormatter for the input format
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            inputFormatter.locale = Locale(identifier: "en_US_POSIX")

            // Create a DateFormatter for the output format
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM, yyyy"
            outputFormatter.locale = Locale(identifier: "en_US")

            // Convert the input date string to a Date object
            if let date = inputFormatter.date(from: dateString) {
                // Convert the Date object to the desired output format string
                let formattedDateString = outputFormatter.string(from: date)
                cell.dateValue.text = formattedDateString
            } else {
                cell.dateValue.text = completeEmailData["update_at"] as? String
            }
            
            
            return cell
        }
        if(indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FraudDetailTableViewCell", for: indexPath) as! FraudDetailTableViewCell
            cell.fraudValue.text =  "\(String(describing: emailDataObject["score"] ?? "-"))"
            cell.email.text =  "\(String(describing: emailDataObject["score"] ?? "-"))"
            cell.phoneClass.text =  "\(String(describing: completePhoneData["score"] ?? "-"))"
            cell.deviceScore.text =  "NA"
            cell.ipScore.text =  "\(String(describing: ipDataObject["score"] ?? "-"))"
            cell.emailRules.text = emailRules == "" ? "-" :  emailRules
            cell.phoneRules.text = phoneRules == "" ? "-" :  phoneRules
            
            return cell
        }
        if(indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneInfoTableViewCell", for: indexPath) as! PhoneInfoTableViewCell
            cell.phoneNumber.text = "\(completePhoneData["number"] ?? "-")"
            cell.score.text = "Score: \(completePhoneData["score"] ?? "-")/100"
            cell.country.text = "\(completePhoneData["country"] ?? "-")"
            cell.valid.text = "\(completePhoneData["valid"] ?? "-")"
            cell.possible.text = "-"
            cell.write.text = "\(completePhoneData["type"] ?? "-")"
            cell.disposable.text = "\(completePhoneData["disposable"] ?? "-")"
            cell.phoneCompany.text = "\(completePhoneData["carrier"] ?? "-")"
            
            cell.phoneProgress.progress = (completePhoneData["score"]) as! Float / 100 // Initial progress
            cell.phoneProgress.trackTintColor = UIColor(red: 220/255, green: 220/255, blue: 217/255, alpha: 1.0)
            cell.phoneProgress.progressTintColor = UIColor(red: 83/255, green: 181/255, blue: 168/255, alpha: 1.0)
            
            return cell
        }
        if(indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisteredPlatformsTableViewCell", for: indexPath) as! RegisteredPlatformsTableViewCell
            cell.platformLabel.text = "Phone number registered platforms"
            cell.platformType = "registered"
            cell.platformsArray = phoneRegisteredPlatforms
            return cell

        }
        if(indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisteredPlatformsTableViewCell", for: indexPath) as! RegisteredPlatformsTableViewCell
            cell.platformLabel.text = "Not registered platforms"
            cell.platformType = "notregistered"
            cell.platformsArray = phoneUnRegisteredPlatforms
            return cell

        }
        
        if(indexPath.row == 5) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailInfoTableViewCell", for: indexPath) as! EmailInfoTableViewCell
            cell.emailLabel.text = emailDataObject["email"] as? String
            cell.emailScore.text = "Score: \(String(describing: emailDataObject["score"] ?? "-"))/100"
            
            cell.deliveryLabel.text = emailDataObject["deliverable"] as? Bool == true ? "true" : "false"
            
            cell.dataBreachesLabel.text = "\(String(describing: emailBreachDetails["number_of_breaches"] ?? "-"))"
            cell.firstBreachLabel.text = "\(String(describing: emailBreachDetails["first_breach"] ?? "-"))"
            
            cell.progressView.progress = (emailDataObject["score"]) as! Float / 100 // Initial progress
            cell.progressView.trackTintColor = UIColor(red: 220/255, green: 220/255, blue: 217/255, alpha: 1.0)
            cell.progressView.progressTintColor = UIColor(red: 83/255, green: 181/255, blue: 168/255, alpha: 1.0)
            
            return cell

        }
        
        if(indexPath.row == 6) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisteredPlatformsTableViewCell", for: indexPath) as! RegisteredPlatformsTableViewCell
            cell.platformLabel.text = "Email registered platforms"
            cell.platformType = "notregistered"
            cell.platformsArray = emailRegisteredPlatforms
            return cell

        }
        
        if(indexPath.row == 7) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisteredPlatformsTableViewCell", for: indexPath) as! RegisteredPlatformsTableViewCell
            cell.platformLabel.text = "Not registered platforms"
            cell.platformType = "registered"
            cell.platformsArray = emailUnRegisteredPlatforms
            return cell

        } 
        if(indexPath.row == 8) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DomainDetailTableViewCell", for: indexPath) as! DomainDetailTableViewCell
            cell.domainsData = domainDetailsArray
            return cell

        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "EmailInfoTableViewCell", for: indexPath) as! EmailInfoTableViewCell
                    return cell
       
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0) {
            return UITableView.automaticDimension
        }
        if(indexPath.row == 3) {
            let result1 = (divideAndRoundUp(phoneRegisteredPlatforms.count))
            
            let col = result1 * 60
            let col3 = col + 70
            
            if(col3 < 100) {
                return 100
            }

            return CGFloat(col3)
        }
        if(indexPath.row == 4) {
            let result1 = (divideAndRoundUp(phoneUnRegisteredPlatforms.count))
            let col = result1 * 60
            let col3 = col + 70
            if(col3 < 100) {
                return 100
            }
            return CGFloat(col3)
        }
        if(indexPath.row == 6) {
            let result1 = (divideAndRoundUp(emailRegisteredPlatforms.count))
            let col = result1 * 60
            let col3 = col + 70
            if(col3 < 100) {
                return 100
            }
            return CGFloat(col3)
        }
        if(indexPath.row == 7) {
            let result1 = (divideAndRoundUp(emailUnRegisteredPlatforms.count))
            let col = result1 * 60
            let col3 = col + 70
            if(col3 < 100) {
                return 100
            }
            return CGFloat(col3)
        }
        
        if(indexPath.row == 8) {
            return (CGFloat(domainDetailsArray.count * 50)) + 50
        }
        
        return UITableView.automaticDimension
    }
    
    func divideAndRoundUp(_ number: Int) -> Int {
        return Int(ceil(Double(number) / 2.0))
    }


}
