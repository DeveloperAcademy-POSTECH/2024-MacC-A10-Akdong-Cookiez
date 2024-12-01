//
//  CustomFont.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import Foundation

enum CustomFont: String {
  case gmarketSansMedium = "GmarketSansTTFMedium"
  case gmarketSansBold = "GmarketSansTTFBold"

  var name: String {
    return self.rawValue
  }
}
