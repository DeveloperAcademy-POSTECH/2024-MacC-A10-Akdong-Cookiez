//
//  MockUserRecord.swift
//  AKCOOTests
//
//  Created by Anjin on 12/2/24.
//

@testable import AKCOO
import XCTest

struct MockUserRecord {
  static let dummy = UserRecord(
    userQuestion: UserQuestion(
      country: CountryProfile(
        name: "베트남",
        currency: Currency(
          unitTitle: "동",
          unit: 0.055
        )
      ),
      category: "카테고리1",
      amount: 100000.0
    ),
    userJudgment: JudgmentType.buying,
    externalJudgment: [
      "해외짹": .buying,
      "한국짹": .notBuying,
      "나짹": .buying
    ]
  )
}
