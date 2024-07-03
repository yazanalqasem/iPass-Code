//
//  JsonDataHandler.swift
//  SdkSkelton
//
//  Created by MOBILE on 17/06/24.
//

import Foundation

class JsonDataHandlerClass {
    func getJsonParserdData() -> [String: Any]? {
            // Convert JSON string to Data
        guard let jsonData = LocalDataHanlder.shared.scannedJsonResponse.data(using: .utf8) else {
                print("Failed to convert JSON string to Data")
                return nil
            }
            
            do {
                // Convert Data to Dictionary
                let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
                return jsonDict
            } catch {
                // Handle the error
                print("Failed to convert JSON string to Dictionary: \(error.localizedDescription)")
                return nil
            }
        }
}


