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
    guard
      let userRecordAmount = standards?.amount
    else {
      print("직전 소비가 없어요")
      return .buying
    }
    
    return userAmount <= userRecordAmount ? .buying : .notBuying
  }
}
