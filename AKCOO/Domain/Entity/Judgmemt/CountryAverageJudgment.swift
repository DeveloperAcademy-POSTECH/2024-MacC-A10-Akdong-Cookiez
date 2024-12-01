//
//  CoutryAverageJudgment.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

struct CountryAverageJudgment: Judgment {
  var userQuestion: UserQuestion
  var standards: [Item]
  var name: String { return "평균" }
  var result: JudgmentType {
    guard let average = averageOfItems else { return .notBuying }
    let isBelowOrEqualAverage = userAmount <= average
    if isBelowOrEqualAverage {
      return .buying
    } else {
      return .notBuying
    }
  }
  
  var userAmount: Double {
    return userQuestion.amount
  }
}

extension CountryAverageJudgment {
  // 값 기준 오름차순으로 정렬 (작은 값부터)
  var sortedItems: [Item] {
    standards
      .filter { $0.category == userQuestion.category }
      .sorted { $0.amount < $1.amount }
  }
  
  // 기준값 중 가장 작은 값
  var minimumAmountOfItems: Double? {
    guard let minimumItem = sortedItems.first else { return nil }
    return minimumItem.amount
  }
  
  // 기준값 중 가장 큰 값
  var maximumAmountOfItems: Double? {
    guard let maximumItem = sortedItems.last else { return nil }
    return maximumItem.amount
  }
  
  // 기준값 평균
  var averageOfItems: Double? {
    // 기준이 비어있다면 nil 반환
    guard sortedItems.isEmpty == false else { return nil }
    // 기준값들의 합
    let total = sortedItems.reduce(0.0) { (sum, item) in
      sum + item.amount
    }
    
    let average = total / Double(sortedItems.count)
    return average
  }
}
