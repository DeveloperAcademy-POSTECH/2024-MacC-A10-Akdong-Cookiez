//
//  MockCountryAverageJudgment.swift
//  AKCOOTests
//
//  Created by Anjin on 11/29/24.
//

@testable import AKCOO
import XCTest

struct MockCountryAverageJudgment {
  static func makeJudgment(
    userAmount: Double,
    countryProfile: CountryProfile,
    category: String,
    sortedItems: [Item]
  ) -> CountryAverageJudgment {
    return CountryAverageJudgment(
      userQuestion: UserQuestion(
        country: countryProfile,
        category: category,
        amount: userAmount
      ),
      standards: sortedItems
    )
  }
}
