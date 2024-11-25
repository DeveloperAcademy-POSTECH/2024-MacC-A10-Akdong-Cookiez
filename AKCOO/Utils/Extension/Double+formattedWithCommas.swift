//
//  Double+formattedWithCommas.swift
//  AKCOO
//
//  Created by Anjin on 11/26/24.
//

import Foundation

extension Double {
  func formattedWithCommas(maxDecimalPlaces: Int = 2) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = maxDecimalPlaces
    return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
  }
}
