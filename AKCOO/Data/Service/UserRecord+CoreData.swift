//
//  UserRecord+CoreData.swift
//  AKCOO
//
//  Created by Anjin on 11/22/24.
//

import CoreData

extension UserRecord {
  static func toEntity(context: NSManagedObjectContext, record: UserRecord) -> UserRecordEntity {
    let entity = UserRecordEntity(context: context)
    entity.id = record.id
    entity.date = record.date
    entity.userJudgment = record.userJudgment.rawValue
    
    // Relationships
    entity.country = CountryProfile
      .toEntity(
        context: context,
        profile: record.country
      )
    
    entity.userQuestion = UserQuestion
      .toEntity(
        context: context,
        question: record.userQuestion
      )
    
    // ExternalJudgment
    let judgments = record.externalJudgment.map { key, type in
      ExternalJudgmentEntity
        .toEntity(
          context: context,
          key: key,
          type: type
        )
    }
    
    entity.addToExternalJudgments(NSSet(array: judgments))
    
    return entity
  }
  
  static func fromEntity(entity: UserRecordEntity) -> Result<UserRecord?, Error> {
    guard
      let id = entity.id,
      let date = entity.date,
      let countryProfileEntity = entity.country,
      let userQuestionEntity = entity.userQuestion,
      let userJudgmentString = entity.userJudgment,
      let userJudgment = JudgmentType(rawValue: userJudgmentString),
      let externalJudgmentEntities = entity.externalJudgments as? Set<ExternalJudgmentEntity>
    else {
      // 값이 없는 경우, Success 형태지만 nil로 반환
      return .success(nil)
    }
    
    // 짹짹이들의 판단 Entity에서 변환
    var externalJudgments: [String: JudgmentType] = [:]
    for judgment in externalJudgmentEntities {
      guard
        let key = judgment.key,
        let rawValue = judgment.judgmentType,
        let type = JudgmentType(rawValue: rawValue)
      else {
        // 변환실패
        return .failure(CoreDataError.mapFromEntityFailed)
      }
      externalJudgments[key] = type
    }
    
    do {
      guard
        let countryProfile = try CountryProfile
          .fromEntity(entity: countryProfileEntity)
          .get()
      else {
        // 값이 없는 경우, Success 형태지만 nil로 반환
        return .success(nil)
      }
      
      guard
        let userQuestion = try UserQuestion
          .fromEntity(entity: userQuestionEntity)
          .get()
      else {
        // 값이 없는 경우, Success 형태지만 nil로 반환
        return .success(nil)
      }
      
      let userRecord = UserRecord(
        id: id,
        date: date,
        country: countryProfile,
        userQuestion: userQuestion,
        userJudgment: userJudgment,
        externalJudgment: externalJudgments
      )
      
      return .success(userRecord)
    } catch {
      return .failure(error)
    }
  }
}
