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
  
  case gmarketBold14
  case gmarketBold16
  case gmarketBold18
  case gmarketBold20
  
  var customFont: String {
    switch self {
    case .gmarketMedium12, .gmarketMedium13, .gmarketMedium14, .gmarketMedium16:
      return CustomFont.gmarketSansMedium.name
      
    case .gmarketBold14, .gmarketBold16, .gmarketBold18, .gmarketBold20:
      return CustomFont.gmarketSansBold.name
    }
  }
  
  var size: CGFloat {
    switch self {
    case .gmarketMedium12: 12
    case .gmarketMedium13: 13
    case .gmarketMedium14: 14
    case .gmarketMedium16: 16
      
    case .gmarketBold14: 14
    case .gmarketBold16: 16
    case .gmarketBold18: 18
    case .gmarketBold20: 20
    }
  }
}
