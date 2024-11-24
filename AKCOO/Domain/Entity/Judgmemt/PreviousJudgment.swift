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
  var result: JudgmentType {
    // TODO: - 조건 만들기
    return .notBuying
  }
}
