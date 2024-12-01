//
//  MockItem.swift
//  AKCOOTests
//
//  Created by Anjin on 11/29/24.
//

@testable import AKCOO
import XCTest

struct MockItem {
  static func makeItem(
    name: String,
    category: String,
    amount: Double
  ) -> Item {
    return Item(
      category: category,
      name: name,
      amount: amount
    )
  }
}
