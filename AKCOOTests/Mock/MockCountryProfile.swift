//
//  MockCountryProfile.swift
//  AKCOOTests
//
//  Created by Anjin on 11/29/24.
//

@testable import AKCOO
import XCTest

struct MockCountryProfile {
  static func makeProfile(
    name: String,
    unitTitle: String,
    unitExchangeRate: Double
  ) -> CountryProfile {
    return CountryProfile(
      name: name,
      currency: Currency(
        unitTitle: unitTitle,
        unit: unitExchangeRate
      )
    )
  }
}
