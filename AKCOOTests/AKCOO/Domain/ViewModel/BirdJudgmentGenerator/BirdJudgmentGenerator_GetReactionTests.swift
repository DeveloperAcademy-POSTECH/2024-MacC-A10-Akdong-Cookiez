//
//  BirdJudgmentGenerator_GetReactionTests.swift
//  AKCOOTests
//
//  Created by Anjin on 11/29/24.
//

@testable import AKCOO
import XCTest

final class BirdJudgmentGenerator_GetReactionTests: XCTestCase {
  var generator: BirdJudgmentGenerator!
  
  override func setUp() {
    super.setUp()
    generator = ForeignBirdJudgmentGenerator()
  }
  
  override func tearDown() {
    generator = nil
    super.tearDown()
  }
  
  func test_중복되지않는값의개수0_출력weakYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 0.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 0.0
          ),
        category: "카테고리1",
        sortedItems: []
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .weakYes)
  }
  
  func test_중복되지않는값의개수1_출력weakYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 150.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 0.0
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0)]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .weakYes)
  }
  
  func test_중복되지않는값의개수2_입력이최소_출력strongYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 50.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 200.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .strongYes)
  }
  
  func test_중복되지않는값의개수2_입력이최소보다크고평균보다작음_출력mediumYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 130.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 200.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .mediumYes)
  }
  
  func test_중복되지않는값의개수2_입력이평균과같음_출력mediumYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 150.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 200.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .mediumYes)
  }
  
  func test_중복되지않는값의개수2_입력이평균보다크고최대보다작음_출력mediumNo() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 170.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 200.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .mediumNo)
  }
  
  func test_중복되지않는값의개수2_입력이최대와같음_출력mediumNo() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 200.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 200.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .mediumNo)
  }
  
  func test_중복되지않는값의개수2_입력이최대보다큼_출력strongNo() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 250.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 200.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .strongNo)
  }
  
  func test_중복되지않는값의개수3_입력이최소_출력strongYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 50.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 200.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 300.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .strongYes)
  }
  
  func test_중복되지않는값의개수3_입력이최소보다크고나머지보다작음_출력strongYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 110.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 180.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 300.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .mediumYes)
  }
  
  func test_중복되지않는값의개수3_입력이평균과같음_출력weakYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 200.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 200
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 200.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 300.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .weakYes)
  }
  
  func test_중복되지않는값의개수3_입력이최대보다큼_출력strongYes() {
    // Arrange
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 400.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 100
          ),
        category: "카테고리1",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카테고리1", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 180.0),
          MockItem.makeItem(name: "품목2", category: "카테고리1", amount: 300.0)
        ]
      )
    
    // Act
    let reaction = generator
      .getReaction(
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertEqual(reaction, .strongNo)
  }
}
