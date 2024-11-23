//
//  UserRecord+toEntity.swift
//  AKCOO
//
//  Created by Anjin on 11/24/24.
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
}
