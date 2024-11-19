//
//  Record.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

/// 사용자 지출 판단 기록 
struct UserRecord {
  let date: Date
  var currency: Currency
  var userQuestion: UserQuestion
  var userJudgment: JudgmentType
  var externalJudgment: [String:JudgmentType]
}

extension UserRecord: Standard {
  var name: String { return "직전 소비" }
  var amount: Double { return userQuestion.amount }
}
