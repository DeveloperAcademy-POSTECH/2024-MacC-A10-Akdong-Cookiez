//
//  CustomFont.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import Foundation

enum CustomFont: String {
  case gmarketSansMedium = "GmarketSansTTFMedium"
  case gmarketSansLight = "GmarketSansTTFLight"
  
  case sfMonoRegular = "SFMonoRegular"
  case sfMonoMedium = "SFMonoMedium"
  case sfMonoSemibold = "SFMonoSemibold"
  
  var name: String {
    return self.rawValue
  }
}
