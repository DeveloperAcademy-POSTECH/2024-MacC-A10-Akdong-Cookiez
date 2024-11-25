//
//  BirdJudgmentGenerator+getReaction.swift
//  AKCOO
//
//  Created by Anjin on 11/26/24.
//

import Foundation

extension BirdJudgmentGenerator {
  func getReaction(judgmentCriteria: CountryAverageJudgment) -> BirdReaction {
    // 판단 정보
    let input = judgmentCriteria.userAmount
    let sortedItems = judgmentCriteria.sortedItems
    let average = judgmentCriteria.averageOfItems ?? 0.0
    
    // 기준들 최소, 최대
    guard
      let minimum = judgmentCriteria.minimumAmountOfItems,
      let maximum = judgmentCriteria.maximumAmountOfItems
    else {
      return .mediumYes
    }
    
    // 값이 중복되는 경우를 제외한 기준들의 값
    let uniqueAmounts = Set(sortedItems.map { $0.amount })
    switch uniqueAmounts.count {
    case ...1:
      // 중복된 값을 제외한 item이 1개일 때
      // 모든 amount가 동일하다면 기준 1개와 동일한 .weakYes 반환
      // item이 1개 미만인 경우는 없겠지만, 혹시 그런 경우의 기본값 제공.
      return .weakYes
    
    case 2:
      // 중복된 값을 제외한 item이 2개일 때
      guard sortedItems.count >= 2 else { return .mediumYes }
      return getReactionWithTwoCriteria(
        input: input,
        min: minimum,
        max: maximum,
        average: average
      )
      
    case 3...:
      // 중복된 값을 제외한 item이 3개 이상일 때
      guard sortedItems.count >= 3 else { return .mediumYes }
      return getReactionWithMultipleCriteria(
        sortedItems: sortedItems,
        input: input,
        min: minimum,
        max: maximum,
        average: average
      )
      
    default:
      // 기본
      return .weakYes
    }
  }
  
  // 기준이 2개일 때
  private func getReactionWithTwoCriteria(
    input: Double,
    min minimum: Double,
    max maximum: Double,
    average: Double
  ) -> BirdReaction {
    switch input {
    case ...minimum:
      return .strongYes
    case ...average:
      return .mediumYes
    case ...maximum:
      return .mediumNo
    case maximum...:
      return .strongNo
    default:
      return .mediumYes
    }
  }
  
  // 기준이 3개 이상일 때
  private func getReactionWithMultipleCriteria(
    sortedItems: [Item],
    input: Double,
    min minimum: Double,
    max maximum: Double,
    average: Double
  ) -> BirdReaction {
    if input == average {
      // 입력금액 == 평균
      return .weakYes
    } else if input < average {
      // 입력금액 < 평균
      return getReactionWithMultipleCriteriaForBelowAverage(
        sortedItems: sortedItems,
        input: input,
        min: minimum,
        max: maximum,
        average: average
      )
    } else {
      // 평균 < 입력금액
      return getReactionWithMultipleCriteriaForAboveAverage(
        sortedItems: sortedItems,
        input: input,
        min: minimum,
        max: maximum,
        average: average
      )
    }
  }
  
  // 기준이 3개일 때 - 평균보다 작을 때
  private func getReactionWithMultipleCriteriaForBelowAverage(
    sortedItems: [Item],
    input: Double,
    min minimum: Double,
    max maximum: Double,
    average: Double
  ) -> BirdReaction {
    let lowerThanAverageItems = sortedItems
      .filter { $0.amount < average }
      .sorted { $0.amount < $1.amount }
    
    // 모든 amount가 동일하다면 기준 1개와 동일한 .mediumYes 반환
    let uniqueAmountsOfLowerThanAverageItems = Set(lowerThanAverageItems.map { $0.amount })
    guard let maximumOfLowerItems = lowerThanAverageItems.last?.amount else { return .mediumYes }
    
    switch uniqueAmountsOfLowerThanAverageItems.count {
    case ...1:
      return input <= minimum ? .strongYes : .mediumYes
      
    case 2...:
      if input <= minimum {
        return .strongYes
      } else if input < maximumOfLowerItems {
        return .mediumYes
      } else {
        return .weakYes
      }
      
    default:
      return .mediumYes
    }
  }
  
  // 기준이 3개일 때 - 평균보다 클 때
  private func getReactionWithMultipleCriteriaForAboveAverage(
    sortedItems: [Item],
    input: Double,
    min minimum: Double,
    max maximum: Double,
    average: Double
  ) -> BirdReaction {
    let largerThanAverageItems = sortedItems
      .filter { $0.amount > average }
      .sorted { $0.amount < $1.amount }
    
    // 모든 amount가 동일하다면 기준 1개와 동일한 .mediumNo 반환
    let uniqueAmountsOfLargerThanAverageItems = Set(largerThanAverageItems.map { $0.amount })
    guard let minimumOfLargerItems = largerThanAverageItems.first?.amount else { return .mediumYes }
    
    switch uniqueAmountsOfLargerThanAverageItems.count {
    case ...1:
      return input > maximum ? .strongNo : .mediumNo
      
    case 2...:
      if input >= maximum {
        return .strongNo
      } else if input > minimumOfLargerItems {
        return .mediumNo
      } else {
        return .weakNo
      }
      
    default:
      return .mediumYes
    }
  }

}
