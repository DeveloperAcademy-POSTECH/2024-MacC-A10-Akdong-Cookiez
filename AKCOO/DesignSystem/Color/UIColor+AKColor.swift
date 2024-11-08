//
//  UIColor+AKColor.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import UIKit

extension UIColor {
  enum AkColorType: String {
    case white = "#FFFFFF"
    case gray1 = "#F1F1F1"
    case gray2 = "#B3B3B3"
    case gray3 = "#8E8E93"
    case black = "#000000"
    
    case akOrange = "#F64E05"
    case akGreen = "#DCED59"
    
    case akPurple = "#EFD0F4"
    case akSubGreen = "#E3F4DC"
    case akRed = "#FFD8D6"
    case akYellow = "#FFF4CA"
    case akBlue = "#D0E0F4"
  }
  
  static func akColor(_ type: AkColorType) -> UIColor {
    return UIColor(hexCode: type.rawValue)
  }
}
