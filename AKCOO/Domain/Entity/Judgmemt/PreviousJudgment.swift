//
//  PreviousJudgment.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

struct PreviousJudgment: Judgment {
  var userAmount: Double
  var standards: UserRecord?
  
  var name: String { return "직전 소비" }
  var result: JudgmentType {
    // TODO: - 조건 만들기
    return .notBuying
  }
}
