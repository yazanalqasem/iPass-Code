//
//  ImageConverter.swift
//  SdkSkelton
//
//  Created by MOBILE on 17/06/24.
//

import Foundation
import UIKit

class ImageConverter {
    // Method to convert Base64 string to UIImage
    func convertBase64ToImage(base64String: String) -> UIImage? {
        // Decode Base64 string to Data
        guard let imageData = Data(base64Encoded: base64String) else {
            print("Failed to decode Base64 string to Data")
            return nil
        }
        
        // Create UIImage from Data
        return UIImage(data: imageData)
    }
}
