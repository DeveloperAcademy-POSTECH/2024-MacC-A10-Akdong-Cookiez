//
//  Budget.swift
//  AKCOO
//
//  Created by 박혜운 on 11/7/24.
//

import Foundation

struct Budget {
  var total: Int
  
  mutating func spend(_ amount: Int) {
    total -= amount
  }
}
