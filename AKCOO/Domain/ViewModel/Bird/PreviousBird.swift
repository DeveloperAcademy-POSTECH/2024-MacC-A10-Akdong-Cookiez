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
  
  var opinion: String {
    if let previousUserRecord {
      if judgment == true {
        // 사!
        if userQuestion.amount == previousUserRecord.amount {
          return "오! 지난 번과 같은 금액이야"
        } else  {
          return previousUserRecord.userJudgment == .buying
          ? "뭘 고민해! 지난 번보다 저렴해!"
          : "이번에 놓치면 아까운 가격인데"
        }
      } else {
        // 사지마!
        return previousUserRecord.userJudgment == .buying
          ? "음.. 지난 구매보다 비싸"
          : "정말 필요해? 한 번 더 고민해봐"
      }
    } else {
      // 직전 소비 판단이 없을 때
      return "아직 비교할 금액이 없어요"
    }
  }
  
}
