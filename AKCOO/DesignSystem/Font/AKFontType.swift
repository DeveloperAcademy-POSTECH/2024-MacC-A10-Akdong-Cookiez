//
//  AKFontSystem.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import Foundation

enum AKFontType {
  case gmarketMedium32
  case gmarketMedium30
  case gmarketMedium24
  case gmarketMedium16
  case gmarketMedium14
  
  case gmarketLight16
  case gmarketLight12
  
  case monoRegular32
  
  case monoMedium24
  case monoMedium16
  
  case monoSemibold16
  
  var customFont: String {
    switch self {
    case .gmarketMedium32, .gmarketMedium30, .gmarketMedium24, .gmarketMedium16, .gmarketMedium14:
      return CustomFont.gmarketSansMedium.name
      
    case .gmarketLight12, .gmarketLight16:
      return CustomFont.gmarketSansLight.name
      
    case .monoRegular32:
      return CustomFont.sfMonoRegular.name
      
    case .monoMedium16, .monoMedium24:
      return CustomFont.sfMonoMedium.name
      
    case .monoSemibold16:
      return CustomFont.sfMonoSemibold.name
    }
  }
  
  var size: CGFloat {
    switch self {
    case .gmarketMedium32: return 32
    case .gmarketMedium30: return 30
    case .gmarketMedium24: return 24
    case .gmarketMedium16: return 16
    case .gmarketMedium14: return 14
      
    case .gmarketLight16:  return 16
    case .gmarketLight12:  return 12
      
    case .monoRegular32:   return 32

    case .monoMedium24:    return 24
    case .monoMedium16:    return 16
      
    case .monoSemibold16:  return 16
    }
  }
}
