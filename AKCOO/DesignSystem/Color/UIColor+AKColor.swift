//
//  UIColor+AKColor.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import UIKit

extension UIColor {
  enum AkColorType: String {
    case black = "#000000"
    case white = "#FFFFFF"
    
    case akYellow = "#FEECA4"
    case akRed = "#FF8E6B"
    
    case akBlue300 = "#6EB4FF"
    case akBlue400 = "#3685D9"
    case akBlue500 = "#1A76D9"
    case akBlue600 = "#275FBE"
    
    case akGray100 = "#F7F7F7"
    case akGray200 = "#ECECEC"
    case akGray300 = "#8E8E93"
    
    case akOrange = "#FFC87A"
  }
  
  static func akColor(_ type: AkColorType) -> UIColor {
    return UIColor(hexCode: type.rawValue)
  }
}
