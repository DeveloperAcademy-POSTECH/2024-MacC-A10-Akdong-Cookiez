//
//  ExternalJudgmentEntity+CoreData.swift
//  AKCOO
//
//  Created by Anjin on 11/22/24.
//

import CoreData

extension ExternalJudgmentEntity {
  static func toEntity(context: NSManagedObjectContext, key: String, type: JudgmentType) -> ExternalJudgmentEntity {
    let entity = ExternalJudgmentEntity(context: context)
    entity.key = key
    entity.judgmentType = type.rawValue
    return entity
  }
}
