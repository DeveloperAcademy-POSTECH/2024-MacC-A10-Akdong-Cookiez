//
//  BirdJudgmentGenerator_GetDetailTests.swift
//  AKCOOTests
//
//  Created by Anjin on 12/2/24.
//

@testable import AKCOO
import XCTest

final class BirdJudgmentGenerator_GetDetailTests: XCTestCase {
  var generator: BirdJudgmentGenerator!
  
  override func setUp() {
    super.setUp()
    generator = ForeignBirdJudgmentGenerator()
  }
  
  override func tearDown() {
    generator = nil
    super.tearDown()
  }
  
  func test_카테고리가카페일때문구추가() {
    // Arrange
    let birdCountry = MockCountryProfile
      .makeProfile(
        name: "대한민국",
        unitTitle: "원",
        unitExchangeRate: 1.0
      )
    
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 150.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 0.0
          ),
        category: "카페",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카페", amount: 100.0)]
      )
    
    // Act
    let result = generator
      .getDetail(
        country: birdCountry,
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertTrue(result.contains("아메리카노 기준,\n"))
  }
  
  func test_카테고리가카페아닐때() {
    // Arrange
    let birdCountry = MockCountryProfile
      .makeProfile(
        name: "대한민국",
        unitTitle: "원",
        unitExchangeRate: 1.0
      )
    
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 150.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 0.0
          ),
        category: "카페아님",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카페아님", amount: 100.0)]
      )
    
    // Act
    let result = generator
      .getDetail(
        country: birdCountry,
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertFalse(result.contains("아메리카노 기준,\n"))
  }
  
  func test평균디테일_입력평균보다낮음_출력저렴해요() {
    // Arrange
    let birdCountry = MockCountryProfile
      .makeProfile(
        name: "대한민국",
        unitTitle: "원",
        unitExchangeRate: 1.0
      )
    
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 50.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 0.0
          ),
        category: "카페아님",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카페아님", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카페아님", amount: 200.0),
          MockItem.makeItem(name: "품목3", category: "카페아님", amount: 300.0)
        ]
      )
    
    // Act
    let result = generator
      .getDetail(
        country: birdCountry,
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertTrue(result.contains("저렴해요!"))
  }
  
  func test평균디테일_입력평균과같음_출력같아요() {
    // Arrange
    let birdCountry = MockCountryProfile
      .makeProfile(
        name: "대한민국",
        unitTitle: "원",
        unitExchangeRate: 1.0
      )
    
    let judgment = MockCountryAverageJudgment
      .makeJudgment(
        userAmount: 200.0,
        countryProfile: MockCountryProfile
          .makeProfile(
            name: "",
            unitTitle: "",
            unitExchangeRate: 0.0
          ),
        category: "카페아님",
        sortedItems: [
          MockItem.makeItem(name: "품목1", category: "카페아님", amount: 100.0),
          MockItem.makeItem(name: "품목2", category: "카페아님", amount: 200.0),
          MockItem.makeItem(name: "품목3", category: "카페아님", amount: 300.0)
        ]
      )
    
    // Act
    let result = generator
      .getDetail(
        country: birdCountry,
        judgmentCriteria: judgment
      )
    
    // Assert
    XCTAssertTrue(result.contains("과 같아요!"))
  }
}
