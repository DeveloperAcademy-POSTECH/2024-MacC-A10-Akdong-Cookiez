//
//  UserQuestion+fromEntity.swift
//  AKCOO
//
//  Created by Anjin on 11/24/24.
//

import CoreData

extension UserQuestion {
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
