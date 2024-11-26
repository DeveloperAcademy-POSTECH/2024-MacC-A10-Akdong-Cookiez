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
  
  init(judgment: PreviousJudgment) {
    self.judgmentCriteria = judgment
  }
  
  var criteriaName: String { return judgmentCriteria.name }
  var judgment: Bool { return judgmentCriteria.result == .buying }
  
  var name: String { "지난 날의 나" }
  var information: String { return "직전 소비로만 판단해!" }
  
  private var userQuestion: UserQuestion { return judgmentCriteria.userQuestion }
  private var previousUserRecord: UserRecord? { return judgmentCriteria.standards }
  
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
      return "아직 비교할 금액이 없어"
    }
  }
  
  var detail: String {
    if let previousUserRecord {
      let unitTitle = userQuestion.country.currency.unitTitle  // 요청한 통화 (ouput: "원")
      let category = userQuestion.category                     // 요청한 카테고리 (ouput: "숙소")
      
      let dateString = previousUserRecord.date.toCompactKoreanDateString()  // 직전 소비 날짜 (output: "24년 11월 11일")
      
      let previousAmount = previousUserRecord.amount.formattedWithCommas()  // 직전 소비 값
      let difference = previousUserRecord.amount - userQuestion.amount      // 직전 소비와 입력 값의 차이
      let absoluteDifference = abs(difference).formattedWithCommas()        // 차이의 절댓값
      
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

extension PreviousBird {
  var graphInfos: BirdReactionGraphInfo {
    // 직전소비값
    guard
      let previousAmount = previousUserRecord?.amount
    else {
      return .init(
        criteriaTitle: judgmentCriteria.name,
        minimum: nil,
        maximum: nil,
        userAmount: userQuestion.amount)
    }
    
    // 차이
    let difference = abs(previousAmount - userQuestion.amount)
    
    // 최소, 최대
    let minimum: Double? = previousAmount - (2 * difference)
    let maximum: Double? = previousAmount + (2 * difference)
    
    // 결과
    return .init(
      criteriaTitle: judgmentCriteria.name,
      minimum: minimum,
      maximum: maximum,
      userAmount: userQuestion.amount
    )
  }
}
