//
//  AKFontSystem.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import Foundation

enum AKFontType {
  case gmarketMedium12
  case gmarketMedium13
  case gmarketMedium14
  case gmarketMedium16
  case gmarketMedium24
  case gmarketMedium30
  
  case gmarketBold13
  case gmarketBold14
  case gmarketBold16
  case gmarketBold18
  case gmarketBold20
  case gmarketBold30
  
  var customFont: String {
    switch self {
    case .gmarketMedium12, .gmarketMedium13, .gmarketMedium14, .gmarketMedium16, .gmarketMedium24, .gmarketMedium30:
      return CustomFont.gmarketSansMedium.name
      
    case .gmarketBold13, .gmarketBold14, .gmarketBold16, .gmarketBold18, .gmarketBold20, .gmarketBold30:
      return CustomFont.gmarketSansBold.name
    }
  }
  
  var size: CGFloat {
    switch self {
    case .gmarketMedium12: 12
    case .gmarketMedium13: 13
    case .gmarketMedium14: 14
    case .gmarketMedium16: 16
    case .gmarketMedium24: 24
    case .gmarketMedium30: 30
      
    case .gmarketBold13: 13
    case .gmarketBold14: 14
    case .gmarketBold16: 16
    case .gmarketBold18: 18
    case .gmarketBold20: 20
    case .gmarketBold30: 30
    }
  }
}
