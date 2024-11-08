//
//  Expense.swift
//  AKCOO
//
//  Created by 박혜운 on 11/7/24.
//

import Foundation

struct Expense: Identifiable {
  let id: String = UUID.init().uuidString
  var date: Date
  var amount: Int
}
