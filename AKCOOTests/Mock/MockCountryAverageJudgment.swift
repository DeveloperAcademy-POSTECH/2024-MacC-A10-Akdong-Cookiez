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
  
  static let onlyCategory: CountryAverageJudgment = CountryAverageJudgment(
    userQuestion: UserQuestion(
      country: CountryProfile(
        name: "나라",
        currency: Currency(
          unitTitle: "통화",
          unit: 1.0
        )
      ),
      category: "카테고리1",
      amount: 0.0
    ),
    standards: [
      Item(category: "카테고리1", name: "품목1", amount: 0.0)
    ]
  )
}
