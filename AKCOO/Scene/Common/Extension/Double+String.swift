//
//  Double+String.swift
//  AKCOO
//
//  Created by 박혜운 on 11/26/24.
//

import Foundation

extension Double {
  var changeToStringNonZeroDot: String {
    if Double(Int(self)) == self  {
      return String(Int(self))
    } else {
      return String(self)
    }
  }
}
