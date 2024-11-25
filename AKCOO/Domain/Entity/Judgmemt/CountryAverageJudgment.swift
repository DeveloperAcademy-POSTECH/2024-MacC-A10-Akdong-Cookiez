//
//  CoutryAverageJudgment.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

struct CountryAverageJudgment: Judgment {
  var userAmount: Double
  var standards: [Item]
  
  var name: String { return "평균" }
  var result: JudgmentType {
    // TODO: - 조건 만들기
    return .buying
  }
}
