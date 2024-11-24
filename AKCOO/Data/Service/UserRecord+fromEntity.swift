//
//  UserRecord+fromEntity.swift
//  AKCOO
//
//  Created by Anjin on 11/24/24.
//

import CoreData

extension UserRecord {
  static func fromEntity(entity: UserRecordEntity) -> Result<UserRecord?, Error> {
    guard
      let id = entity.id,
      let date = entity.date,
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
