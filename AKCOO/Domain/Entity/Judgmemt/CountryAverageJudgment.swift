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
  var result: JudgmentType {
    guard let average = averageOfItems else { return .notBuying }
    let isBelowOrEqualAverage = userAmount <= average
    if isBelowOrEqualAverage {
      return .buying
    } else {
      return .notBuying
    }
  }
  
  // 기준값 평균
  private var averageOfItems: Double? {
    // 기준이 비어있다면 nil 반환
    guard standards.isEmpty == false else { return nil }
    // 기준값들의 합
    let total = standards.reduce(0.0) { (sum, item) in
      sum + item.amount
    }
    
    let average = total / Double(standards.count)
    return average
  }
}
