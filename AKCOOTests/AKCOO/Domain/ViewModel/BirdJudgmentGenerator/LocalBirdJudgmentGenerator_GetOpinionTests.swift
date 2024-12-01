//
//  LocalBirdJudgmentGenerator_GetOpinionTests.swift
//  AKCOOTests
//
//  Created by Anjin on 12/1/24.
//

@testable import AKCOO
import XCTest

final class LocalBirdJudgmentGenerator_GetOpinionTests: XCTestCase {
  var generator: BirdJudgmentGenerator!
  
  override func setUp() {
    super.setUp()
    generator = LocalBirdJudgmentGenerator()
  }
  
  override func tearDown() {
    generator = nil
    super.tearDown()
  }
  
  func test_reaction이strongYes일때() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment.onlyCategory
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .strongYes
      )
    
    // Assert
    XCTAssertEqual(result, "한국에서는 볼 수 없는 가격이야")
  }
  
  func test_reaction이mediumYes일때() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment.onlyCategory
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .mediumYes
      )
    
    // Assert
    XCTAssertEqual(result, "한국에서도 저렴한 가격이야")
  }
  
  func test_reaction이weakYes일때() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment.onlyCategory
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .weakYes
      )
    
    // Assert
    XCTAssertEqual(result, "한국이랑 비슷한 편이야")
  }
  
  func test_reaction이weakNo일때() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment.onlyCategory
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .weakNo
      )
    
    // Assert
    XCTAssertEqual(result, "한국보다 조금 비싼 편이야")
  }
  
  func test_reaction이mediumNo일때_category숙소는호캉스로() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 0.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "베트남",
            unitTitle: "동동",
            unitExchangeRate: 0.0
          ),
        category: "숙소",
        sortedItems: [
          MockItem.makeItem(
            name: "품목1",
            category: "숙소",
            amount: 0.0
          )
        ]
      )
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .mediumNo
      )
    
    // Assert
    XCTAssertEqual(result, "차라리 한국에서 호캉스 어때?")
  }
  
  func test_reaction이mediumNo일때() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 0.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "베트남",
            unitTitle: "동동",
            unitExchangeRate: 0.0
          ),
        category: "카페",
        sortedItems: [
          MockItem.makeItem(
            name: "품목1",
            category: "카페",
            amount: 0.0
          )
        ]
      )
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .mediumNo
      )
    
    // Assert
    XCTAssertEqual(result, "차라리 한국에서 카페 어때?")
  }

  func test_reaction이mediumNo일때_category는nil() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 0.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "베트남",
            unitTitle: "동동",
            unitExchangeRate: 0.0
          ),
        category: "숙소",
        sortedItems: []
      )
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .mediumNo
      )
    
    // Assert
    XCTAssertEqual(result, "차라리 한국에서 소비해")
  }
  
  func test_reaction이strongNo일때() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 0.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "베트남",
            unitTitle: "동동",
            unitExchangeRate: 0.0
          ),
        category: "숙소",
        sortedItems: [
          MockItem.makeItem(
            name: "품목1",
            category: "숙소",
            amount: 0.0
          )
        ]
      )
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .strongNo
      )
    
    // Assert
    XCTAssertEqual(result, "너무 비싸! 다른 숙소 찾아봐")
  }
  
  func test_reaction이strongNo일때_category는nil() {
    // Arrange
    let judgmentCriteria = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 0.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "베트남",
            unitTitle: "동동",
            unitExchangeRate: 0.0
          ),
        category: "숙소",
        sortedItems: []
      )
    
    // Act
    let result = generator
      .getOpinion(
        judgmentCriteria: judgmentCriteria,
        reaction: .strongNo
      )
    
    // Assert
    XCTAssertEqual(result, "너무 비싸! 다른 걸 찾아봐")
  }

}
