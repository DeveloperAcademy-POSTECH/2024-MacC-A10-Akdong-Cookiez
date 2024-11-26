//
//  LocalBird.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

/// 한국 물가를 기준하는 새
struct LocalBird: BirdModel {
  private let country: CountryProfile
  var judgmentCriteria: CountryAverageJudgment
  private let judgmentGenerator: BirdJudgmentGenerator
  
  init(
    country: CountryProfile,
    judgment: CountryAverageJudgment
  ) {
    self.country = country
    self.judgmentCriteria = judgment
    self.judgmentGenerator = LocalBirdJudgmentGenerator()
  }
  
  var criteriaName: String { return judgmentCriteria.name }
  var judgment: Bool { return judgmentCriteria.result == .buying }
  
  var name: String { return "한국 토박이" }
  var information: String { return "나는 한국 토박이야!" }
  
  private var convertedToKRWJudgmentCriteria: CountryAverageJudgment {
    var judgmentCriteria = self.judgmentCriteria
    if let unit = judgmentCriteria.userQuestion?.country.currency.unit {
      judgmentCriteria.userAmount *= unit
    }
    return judgmentCriteria
  }
  
  private var birdReaction: BirdReaction {
    return judgmentGenerator
      .getReaction(
        judgmentCriteria: self.convertedToKRWJudgmentCriteria
      )
  }
  
  var opinion: String {
    return judgmentGenerator
      .getOpinion(
        judgmentCriteria: self.convertedToKRWJudgmentCriteria,
        reaction: self.birdReaction
      )
  }
  
  var detail: String {
    return judgmentGenerator
      .getDetail(
        country: self.country,
        judgmentCriteria: self.convertedToKRWJudgmentCriteria
      )
  }
}
