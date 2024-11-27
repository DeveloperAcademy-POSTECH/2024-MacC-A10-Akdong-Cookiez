//
//  LocalBird.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

/// 한국 물가를 기준하는 새
struct LocalBird: BirdModel {
  private let birdCountry: CountryProfile
  private var judgmentCriteria: CountryAverageJudgment
  
  private let judgmentGenerator: BirdJudgmentGenerator
  
  init(
    birdCountry: CountryProfile,     // 새의 국적
    judgment: CountryAverageJudgment // 판단을 위한 정보
  ) {
    self.birdCountry = birdCountry
    self.judgmentCriteria = judgment
    
    self.judgmentGenerator = LocalBirdJudgmentGenerator()
  }
  
  var criteriaName: String { return judgmentCriteria.name }
  var judgment: Bool { return judgmentCriteria.result == .buying }
  
  var name: String { return "한국 토박이" }
  var information: String { return "나는 한국 토박이야!" }
  
  private var userQuestion: UserQuestion {
    return judgmentCriteria.userQuestion
  }
  
  private var convertedToKRWJudgmentCriteria: CountryAverageJudgment {
    let crieteria: CountryAverageJudgment = .init(
      userQuestion: .init(
        country: userQuestion.country,
        category: userQuestion.category,
        amount: userQuestion.amount * userQuestion.country.currency.unit
      ),
      standards: judgmentCriteria.standards
    )
    
    return crieteria
  }
  
  private var birdReaction: BirdReaction {
    return judgmentGenerator
      .getReaction(
        judgmentCriteria: self.convertedToKRWJudgmentCriteria
      )
  }
  
  var opinion: String {
    
    print(convertedToKRWJudgmentCriteria)
    
    return judgmentGenerator
      .getOpinion(
        judgmentCriteria: self.convertedToKRWJudgmentCriteria,
        reaction: self.birdReaction
      )
  }
  
  var detail: String {
    return judgmentGenerator
      .getDetail(
        country: self.birdCountry,
        judgmentCriteria: self.convertedToKRWJudgmentCriteria
      )
  }
}

extension LocalBird {
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
