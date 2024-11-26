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
      let isSameAmount = userQuestion.amount == previousUserRecord.amount
      let wasPreviousJudgmentBuying = previousUserRecord.userJudgment == .buying
      
      if judgment == true {
        // 사!
        if isSameAmount {
          return "오! 지난 번과 같은 금액이야"
        } else {
          return wasPreviousJudgmentBuying
            ? "뭘 고민해! 지난 번보다 저렴해!"
            : "이번에 놓치면 아까운 가격인데"
        }
      } else {
        // 사지마!
        return wasPreviousJudgmentBuying
          ? "음.. 지난 구매보다 비싸"
          : "정말 필요해? 한 번 더 고민해봐"
      }
    } else {
      // 직전 소비 판단이 없을 때
      return "아직 비교할 금액이 없어요"
    }
  }
  
  var detail: String {
    if let previousUserRecord {
      let unitTitle = userQuestion.country.currency.unitTitle
      
      let dateString = previousUserRecord.date.toCompactKoreanDateString()
      let previousAmount = previousUserRecord.amount.formattedWithCommas()
      let difference = previousUserRecord.amount - userQuestion.amount
      let absoluteDifference = abs(difference).formattedWithCommas()
      
      if difference < 0 {
        return "\(dateString)에 '\(previousUserRecord.userJudgment.rawValue)' 버튼을 누른\n<\(userQuestion.category)> \(previousAmount)\(unitTitle)보다\n약 \(absoluteDifference)\(unitTitle) 저렴해요!\n다음에도 비교해서 알려드릴게요."
      } else if difference == 0 {
        return "\(dateString)에 '\(previousUserRecord.userJudgment.rawValue)' 버튼을 누른\n<\(userQuestion.category)> \(previousAmount)\(unitTitle)과\n같은 금액이에요!\n다음에도 비교해서 알려드릴게요."
      } else {
        return "\(dateString)에 '\(previousUserRecord.userJudgment.rawValue)' 버튼을 누른\n<\(userQuestion.category)> \(previousAmount)\(unitTitle)보다\n약 \(absoluteDifference)\(unitTitle) 비싸요!\n다음에도 비교해서 알려드릴게요."
      }
    } else {
      return "<\(userQuestion.category)>의 첫 지출이네요!\n살래요, 안 살래요 버튼을 눌러\n지출 판단 기록을 저장하세요.\n다음부터 비교해서 알려드릴게요!"
    }
  }
}
