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
  
  static func fromEntity(entity: UserRecordEntity) -> Result<UserRecord, Error> {
    guard
      let id = entity.id,
      let date = entity.date,
      let countryProfileEntity = entity.country,
      let userQuestionEntity = entity.userQuestion,
      let userJudgmentString = entity.userJudgment,
      let userJudgment = JudgmentType(rawValue: userJudgmentString)
    else {
      return .failure(CoreDataError.mapFromEntityFailed)
    }
    
    // 짹짹이들의 판단 Entity
    guard
      let externalJudgmentEntities = entity.externalJudgments as? Set<ExternalJudgmentEntity>
    else {
      return .failure(CoreDataError.mapFromEntityFailed)
    }
    
    // 짹짹이들의 판단 Entity에서 변환
    var externalJudgments: [String: JudgmentType] = [:]
    for judgment in externalJudgmentEntities {
      guard
        let key = judgment.key,
        let rawValue = judgment.judgmentType,
        let type = JudgmentType(rawValue: rawValue)
      else {
        return .failure(CoreDataError.mapFromEntityFailed)
      }
      externalJudgments[key] = type
    }
    
    do {
      let countryProfile = try CountryProfile
        .fromEntity(entity: countryProfileEntity)
        .get()
      
      let userQuestion = try UserQuestion
        .fromEntity(entity: userQuestionEntity)
        .get()
      
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
