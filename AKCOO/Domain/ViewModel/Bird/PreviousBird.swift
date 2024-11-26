//
//  PreviousBird.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

/// 직전 소비를 기준하는 새
struct PreviousBird: BirdModel {
  private let judgmentCriteria: PreviousJudgment
  private let userQuestion: UserQuestion
  
  init(userQuestion: UserQuestion, judgment: PreviousJudgment) {
    self.userQuestion = userQuestion
    self.judgmentCriteria = judgment
  }
  
  var criteriaName: String { return judgmentCriteria.name }
  var judgment: Bool { return judgmentCriteria.result == .buying }

  private var birdReaction: BirdReaction { return .mediumNo }
  
  var name: String { "지난 날의 나" }
  var information: String { return "직전 소비로만 판단해!" }
  
  private var previousUserRecord: UserRecord? {
    return judgmentCriteria.standards
  }
  
}
