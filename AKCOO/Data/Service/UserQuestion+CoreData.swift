//
//  UserQuestion+CoreData.swift
//  AKCOO
//
//  Created by Anjin on 11/22/24.
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
  
  static func fromEntity(entity: UserQuestionEntity) -> Result<UserQuestion?, Error> {
    guard
      let country = entity.country,
      let category = entity.category
    else {
      return .success(nil)
    }
    
    let userQuestion = UserQuestion(
      country: country,
      category: category,
      amount: entity.amount
    )
    
    return .success(userQuestion)
  }
}
