//
//  CoreData_EntityMappingTests.swift
//  AKCOOTests
//
//  Created by Anjin on 12/2/24.
//

@testable import AKCOO
import CoreData
import XCTest

final class CoreData_EntityMappingTests: XCTestCase {
  var context: NSManagedObjectContext!
  
  override func setUp() {
    super.setUp()
    let container = MockCoreDataStack.makeInMemoryPersistentContainer()
    context = container.viewContext
  }
  
  override func tearDown() {
    context = nil
    super.tearDown()
  }
  
  func test_ExternalJudgmentToEntity_정상() {
    // Arrange
    let key = "카테고리1"
    let type: JudgmentType = .buying
    
    // Act
    let entity = ExternalJudgmentEntity
      .toEntity(
        context: context,
        key: key,
        type: type
      )
    
    // Assert
    XCTAssertEqual(entity.key, key)
    XCTAssertEqual(entity.judgmentType, type.rawValue)
  }
  
  func test_CountryProfileToEntity_정상() {
    // Arrange
    let profile = MockCountryProfile.korea
    
    // Act
    let entity = CountryProfile.toEntity(context: context, profile: profile)
    
    // Assert
    XCTAssertEqual(entity.name, profile.name)
    XCTAssertEqual(entity.currencyUnitTitle, profile.currency.unitTitle)
    XCTAssertEqual(entity.currencyExchangeRate, profile.currency.unit)
  }
  
  func test_UserQuestionToEntity_정상() {
    // Arrange
    let question = UserQuestion(
      country: MockCountryProfile.korea,
      category: "숙소",
      amount: 150.0
    )
    
    // Act
    let entity = UserQuestion.toEntity(context: context, question: question)
    
    // Assert
    XCTAssertEqual(entity.category, question.category)
    XCTAssertEqual(entity.amount, question.amount)
    XCTAssertEqual(entity.country?.name, question.country.name)
    XCTAssertEqual(entity.country?.currencyUnitTitle, question.country.currency.unitTitle)
    XCTAssertEqual(entity.country?.currencyExchangeRate, question.country.currency.unit)
  }
  
  func test_UserRecordToEntity_정상() {
    // Arrange
    let record = MockUserRecord.dummy
    
    // Act
    let entity = UserRecord.toEntity(context: context, record: record)
    
    // Assert
    XCTAssertEqual(entity.id, record.id)
    XCTAssertEqual(entity.date, record.date)
    XCTAssertEqual(entity.userJudgment, record.userJudgment.rawValue)
  }
  
  func test_CountryProfileFromEntity_정상() throws {
    // Arrange
    let entity = CountryProfileEntity(context: context)
    entity.name = "대한민국"
    entity.currencyUnitTitle = "원"
    entity.currencyExchangeRate = 1.0
    
    // Act
    let result = try CountryProfile.fromEntity(entity: entity).get()
    
    // Assert
    XCTAssertNotNil(result)
    XCTAssertEqual(result?.name, "대한민국")
    XCTAssertEqual(result?.currency.unitTitle, "원")
    XCTAssertEqual(result?.currency.unit, 1.0)
  }
  
  func test_UserQuestionFromEntity_정상() throws {
    // Arrange
    let countryEntity = CountryProfileEntity(context: context)
    countryEntity.name = "대한민국"
    countryEntity.currencyUnitTitle = "원"
    countryEntity.currencyExchangeRate = 1.0
    
    let questionEntity = UserQuestionEntity(context: context)
    questionEntity.country = countryEntity
    questionEntity.category = "카테고리1"
    questionEntity.amount = 150.0
    
    // Act
    let result = try UserQuestion.fromEntity(entity: questionEntity).get()
    
    // Assert
    XCTAssertNotNil(result)
    XCTAssertEqual(result?.country.name, "대한민국")
    XCTAssertEqual(result?.country.currency.unitTitle, "원")
    XCTAssertEqual(result?.country.currency.unit, 1.0)
    XCTAssertEqual(result?.category, "카테고리1")
    XCTAssertEqual(result?.amount, 150.0)
  }
  
  func test_UserRecordFromEntity_정상() throws {
    // Arrange
    let tempUUID = UUID()
    let tempDate = Date()
    
    let userRecordEntity = UserRecordEntity(context: context)
    userRecordEntity.id = tempUUID
    userRecordEntity.date = tempDate
    userRecordEntity.userJudgment = JudgmentType.buying.rawValue
    
    // FIXME: userRecord 내부를 전부 설정해주기
    
    // Act
    let result = try UserRecord.fromEntity(entity: userRecordEntity).get()
    
    // Assert
    XCTAssertNotNil(result)
    XCTAssertEqual(result?.id, tempUUID)
    XCTAssertEqual(result?.date, tempDate)
    XCTAssertEqual(result?.userJudgment, .buying)
  }
}
