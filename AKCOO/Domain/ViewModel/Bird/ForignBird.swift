//
//  ForignBird.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

/// 물가를 기준하는 새
struct ForignBird: BirdModel {
  private let country: CountryProfile
  private let judgmentCriteria: CountryAverageJudgment
  private let judgmentGenerator: BirdJudgmentGenerator

  init(
    country: CountryProfile,
    judgment: CountryAverageJudgment
  ) {
    self.country = country
    self.judgmentCriteria = judgment
    self.judgmentGenerator = ForeignBirdJudgmentGenerator()
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
