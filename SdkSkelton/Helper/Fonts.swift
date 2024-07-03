//
//  Fonts.swift
//  SdkSkelton
//
//  Created by MOBILE on 12/06/24.
//100: Thin
//200: Extra Light (Ultra Light)
//300: Light
//400: Normal (Regular)
//500: Medium
//600: Semi Bold (Demi Bold)
//700: Bold
//800: Extra Bold (Ultra Bold)
//900: Black (Heavy)
//

import Foundation
import UIKit

struct Fonts {
    
    func getFont400(size: Int) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    func getFont500(size: Int) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    func getFont600(size: Int) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    
    let PoppinsRegular400: String = "Poppins-Regular"
    let PoppinsRegular600: String = "Poppins-Regular"
    let PoppinsRegular700: String = "Poppins-Bold"
}
