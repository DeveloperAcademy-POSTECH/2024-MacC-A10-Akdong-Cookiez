//
//  BirdJudgmentGenerator_GetOpinionTests.swift
//  AKCOOTests
//
//  Created by Anjin on 11/29/24.
//

@testable import AKCOO
import XCTest

final class BirdJudgmentGenerator_GetOpinionTests: XCTestCase {
  var generator: BirdJudgmentGenerator!
  
  override func setUp() {
    super.setUp()
    generator = ForeignBirdJudgmentGenerator()
  }
  
  override func tearDown() {
    generator = nil
    super.tearDown()
  }
  
  func test_reaction이strongYes일때_category숙소식당카페() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 0.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "베트남남",
            unitTitle: "동동",
            unitExchangeRate: 0.0
          ),
        // 진짜 필요한 값 + 실제 getOpinion에 parameter를 카테고리로 두는 건 어떨지..
        category: "",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "숙소", amount: 0.0)
        ]
      )
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .strongYes
      )
    
    // Assert
    XCTAssertEqual(result, "뭘 고민해! 무조건 가야지")
  }
  
  func test_reaction이strongYes일때_category기타() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 0.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "베트남남",
            unitTitle: "동동",
            unitExchangeRate: 0.0
          ),
        // 진짜 필요한 값 + 실제 getOpinion에 parameter를 카테고리로 두는 건 어떨지..
        category: "",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 0.0)
        ]
      )
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .strongYes
      )
    
    // Assert
    XCTAssertEqual(result, "뭘 고민해! 무조건 소비해")
  }
}
