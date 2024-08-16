//
//  ViewController.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//

import UIKit
import iPass2_0NativeiOS
import CoreNFC


extension ViewController : iPassSDKManagerDelegate {

    func getScanCompletionResult(result: String, transactionId: String, error: String) {
        print(result)
        print(transactionId)
        print(error)
        if(error == "") {
            LocalDataHanlder.shared.scannedJsonResponse = result
            LocalDataHanlder.shared.scannedTransactionId = transactionId
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScannedDataViewController") as! ScannedDataViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
           
        }
        else {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: transactionId, message: error, preferredStyle: .alert)
                       
                       // Step 3: Add actions
                       let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                           // Handle the OK button tap if needed
                           print("OK button tapped")
                       }
                       alertController.addAction(okAction)
                       
                       // Optionally, add more actions if needed
                       // let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                       // alertController.addAction(cancelAction)
                       
                       // Step 4: Present the alert
                       self.present(alertController, animated: true, completion: nil)
            }
            
            
          
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NFCNDEFReaderSessionDelegate {

    @IBOutlet weak var flowsTableView: UITableView!
    let loadingView = LoadingView()
    var dataDict: [[String: Any]] = []
    
    
    
    
    
//    
    var appToken1 = "eyJhbGciOiJIUzI1NiJ9.aXBhc3Ntb2Jpb3NAeW9wbWFpbC5jb21CaWtyYW0gc2luZ2ggICBjYjg5N2FlNC0wZDg2LTQzZmEtYmZhYy1hZjM0ZTFjOTFkMDM.C-BLHVUeW2nlFWgJGMCJV-w4PcSzq85r81X6bQuzE80"
    var emailStr = "ipassmobios@yopmail.com"
    var passwordStr  =  "Admin@123#"
    
    
    
//    var appToken1 = "eyJhbGciOiJIUzI1NiJ9.dGVzdHdlYmhvb2tpcGFzc0B5b3BtYWlsLmNvbUFqYXkgS3VtYXIgICA1ZDBmMTQ5Yi1jM2ZlLTRlYTUtOGY2ZC1lZmU4NzM2MDg0OTE.Mgl6wdtfkMt3niHgbeRk7RYlB-QflCa69u8U3re1tDo"
//    var emailStr = "testwebhookipass@yopmail.com"
//    var passwordStr  =  "Admin@123#"
    

    
    
    var nfcSession: NFCNDEFReaderSession?
    
   // var userToken = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUIData()
        flowsTableView.register(UINib(nibName: "FlowsTableViewCell", bundle: nil), forCellReuseIdentifier: "FlowsTableViewCell")
       
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(DataManager.shared.processCompleted == true) {
            return
        }
        
        DispatchQueue.main.async {
            self.loadingView.show(in: self.view)
            self.loadingView.updateProgress("")
        }
        
        
        configProperties.setLoaderColor(color: .purple)
        configProperties.needHologramDetection(value: true)
        
        DataBaseDownloading.initialization(dbType: DataBaseDownloading.availableDataSources.fullAuth, completion:{status, error in
            print(status, error)
            if(status == "Start Now") {
               
                iPassSDKManger.UserOnboardingProcess(email: self.emailStr, password: self.passwordStr) { status, tokenString in
                  //  print(tokenString)
                    DispatchQueue.main.async {
                        self.loadingView.hide()
                        if(status == true) {
                            DataManager.shared.processCompleted = true 
                            DataManager.shared.userLoginToken = tokenString!
                           // self.userToken = tokenString!
                            
                        }
                    }
                }
            }
        })
    }
    
    
    
    
    func handleUIData() {
        let flow1: [String: Any] = ["title": "Full Processing", "subtitle": "This flow includes Document Scanning, Document Authenticity, User Liveness, User Face Matching, AML and social media verification", "image": "flow1.png"]
        let flow2: [String: String] = ["title": "IDV + Liveness + AML", "subtitle": "This flow includes Document Scanning, Document Authenticity, User Liveness, User Face Matching and AML check", "image": "flow2.png"]
        let flow3: [String: String] = ["title": "IDV + AML", "subtitle": "This flow includes Document Scanning, Document Authenticity and AML check", "image": "flow3.png"]
        let flow4: [String: String] = ["title": "IDV + Liveness ", "subtitle": "This flow includes Document Scanning, Document Authenticity, User Liveness and User Face Matching", "image": "flow4.png"]
       
        dataDict.append(flow1)
        dataDict.append(flow2)
        dataDict.append(flow3)
        dataDict.append(flow4)
        
    }
    
    // 553c6d85-bfbd-4b61-8d19-d407c091c68e
     //597b482f-4d44-42be-a9ce-a40cdaa1fc1a
//        2261b84f-090e-441f-a5ca-31ba1c71ca25
//        i267130117OSrAIf7kaLaV2024-06-1412-3410031
   //  i277845013OSUrFRcPxGhD2024-06-2611-0810015
     //i38195208OSIhC80SEIbD2024-06-2611-0710011
     // 262a6a13-12b8-4cd6-8296-af7df38df52b
     //i330904380OS8KwSw84n9u2024-06-2613-4710011
     //i925336646OSSI0ki3x5TD2024-06-2719-2110031
//        iPassSDKManger.delegate = self
//        iPassSDKManger.fetchTransaction(transactionId: "i267130117OSrAIf7kaLaV2024-06-1412-3410031", controller: self, appToken: self.appToken1 )
     
     
   //  iPassSDKManger.addLivenessInfoView(ctrl: self)
    
    func startDocScanner (_ flowNumber: Int)  {
      
        
        Task { @MainActor in
            iPassSDKManger.delegate = self
            await iPassSDKManger.startScanningProcess(userEmail: emailStr, flowId: flowNumber,
                                                socialMediaEmail :"bikram4127@gmail.com", phoneNumber : "+919781986132", controller: self, userToken: DataManager.shared.userLoginToken, appToken: self.appToken1 )
            
            
            
           // await iPassSDKManger.addLivenessInfoView()
            
        }
        
        
       
    }
    
    func fetchPublicIPAddress22(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.ipify.org?format=json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching public IP address: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let ipAddress = json["ip"] as? String {
                    completion(ipAddress)
                } else {
                    print("Invalid JSON format.")
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }

    
    
    func fetchPublicIPAddress(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.ipify.org?format=json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching public IP address: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let ipAddress = json["ip"] as? String {
                    completion(ipAddress)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
     func getIPAddress22() -> String? {
        var address : String?

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                // wifi = ["en0"]
                // wired = ["en2", "en3", "en4"]
                // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                
                let name = String(cString: interface.ifa_name)
                if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
    }
    
    func getIPAddress() -> String? {
        var address: String?
        
        // Get list of all interfaces on the device
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // Iterate through the list of interfaces
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            
            // Check for IPv4 or IPv6 interfaces
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Get interface name
                let name = String(cString: interface.ifa_name)
                
                // Only consider Wi-Fi or cellular interfaces
                if name == "en0" || name == "pdp_ip0" {
                    // Convert interface address to a human-readable string
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    var addr = interface.ifa_addr.pointee
                    if (getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        address = String(cString: hostname)
                    }
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return address
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return dataDict.count
        }

        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FlowsTableViewCell", for: indexPath) as! FlowsTableViewCell
        
        let flowData: [String: Any] = dataDict[indexPath.row]
        cell.title.text = flowData["title"] as? String
        cell.subtitle.text = flowData["subtitle"] as? String
        cell.flowImage.image = UIImage(named: (flowData["image"] as? String)!)
        
      

            return cell
        }
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            if let nfcError = error as? NFCReaderError {
                switch nfcError.code {
                case .readerSessionInvalidationErrorUserCanceled:
                    print("User canceled the session.")
                case .readerSessionInvalidationErrorSessionTimeout:
                    print("Session timeout.")
                default:
                    print("Other error: \(nfcError.localizedDescription)")
                }
            } else {
                print("Error: \(error.localizedDescription)")
            }
        }

    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print("NFC Reader session became active")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                print("NFC Tag payload------: \(record)")
                if let payload = String(data: record.payload, encoding: .utf8) {
                    print("NFC Tag payload: \(payload)")
                }
            }
        }
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        
//        if let ipAddress = getIPAddress() {
//            print("IP Address 1: \(ipAddress)")
//        } else {
//            print("Unable to get IP Address")
//        }
//        
//        if let ipAddressww = getIPAddress22() {
//            print("IP Address 2: \(ipAddressww)")
//        } else {
//            print("Unable to get IP Address22")
//        }
//        
//     
//        
//        fetchPublicIPAddress { ipAddress in
//            if let ipAddress = ipAddress {
//                print("IP Address 3 \(ipAddress)")
//            } else {
//                print("Unable to fetch public IP Address")
//            }
//        }
//        
//        
//        fetchPublicIPAddress22 { ipAddress in
//            if let ipAddress = ipAddress {
//                print("Public IP Address 4 : \(ipAddress)")
//            } else {
//                print("Unable to fetch public IP Addressr")
//            }
//        }
        
     
        let flowData: [String: Any] = dataDict[indexPath.row]
       
        if(indexPath.row == 0) {
            DataManager.shared.selectedFlowCode = 10031
             startDocScanner(10031)
//            guard NFCNDEFReaderSession.readingAvailable else {
//                       print("NFC is not available on this device")
//                       return
//                   }
//
//                   nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
//                   nfcSession?.alertMessage = "Hold your iPhone near the NFC tag."
//                   nfcSession?.begin()
            
        }
        else if(indexPath.row == 1) {
            DataManager.shared.selectedFlowCode = 10032
             startDocScanner(10032)
        }
        else if(indexPath.row == 2) {
            DataManager.shared.selectedFlowCode = 10015
             startDocScanner(10015)
        }
        else {
            DataManager.shared.selectedFlowCode = 10011
             startDocScanner(10011)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}


































