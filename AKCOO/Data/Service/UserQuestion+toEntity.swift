//
//  UserQuestion+toEntity.swift
//  AKCOO
//
//  Created by Anjin on 11/24/24.
//

import CoreData

extension UserQuestion {
  static func toEntity(context: NSManagedObjectContext, question: UserQuestion) -> UserQuestionEntity {
    let entity = UserQuestionEntity(context: context)
    entity.country = question.country
    entity.category = question.category
    entity.amount = question.amount
    return entity
  }
}
