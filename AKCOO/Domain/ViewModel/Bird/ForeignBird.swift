//
//  ForeignBird.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

/// 물가를 기준하는 새
struct ForeignBird: BirdModel {
  private let judgmentCriteria: CountryAverageJudgment
  private let judgmentGenerator: BirdJudgmentGenerator
  
  init(judgment: CountryAverageJudgment) {
    let filteredJudgment = CountryAverageJudgment(
      userQuestion: judgment.userQuestion,
      standards: judgment.standards.filter { $0.category == judgment.userQuestion.category }
    )
    
    self.judgmentCriteria = filteredJudgment
    self.judgmentGenerator = ForeignBirdJudgmentGenerator()
  }
  
  private var country: CountryProfile {
    return judgmentCriteria.userQuestion.country
  }
  
  var judgment: Bool { return judgmentCriteria.result == .buying }
  
  var name: String { return "\(country.name) 10년차" }
  var information: String { return "나는 \(country.name) 10년 차 짹짹이야! \(country.name)의 평균물가를 기준으로 너의 지출들을 판단해줄게!" }
  
  private var birdReaction: BirdReaction {
    return judgmentGenerator
      .getReaction(
        judgmentCriteria: self.judgmentCriteria
      )
  }
  
  var opinion: String {
    return judgmentGenerator
      .getOpinion(
        judgmentCriteria: self.judgmentCriteria,
        reaction: self.birdReaction
      )
  }
  
  var detail: String {
    return judgmentGenerator
      .getDetail(
        country: self.country,
        judgmentCriteria: self.judgmentCriteria
      )
  }
}

extension ForeignBird {
  var graphInfos: BirdReactionGraphInfo {
    guard
      let minAmount = judgmentCriteria.minimumAmountOfItems,
      let maxAmount = judgmentCriteria.maximumAmountOfItems
    else {
      return .init(
        criteriaTitle: judgmentCriteria.name,
        minimum: nil,
        maximum: nil,
        userAmount: judgmentCriteria.userAmount
      )
    }
    
    // 평균, 차이
    let average = (maxAmount + minAmount) / 2
    let difference = maxAmount - minAmount
    
    // 최소, 최대
    let minimum: Double? = average - difference
    let maximum: Double? = average + difference
    
    // 결과
    return .init(
      criteriaTitle: judgmentCriteria.name,
      minimum: minimum,
      maximum: maximum,
      userAmount: judgmentCriteria.userAmount
    )
  }
}
