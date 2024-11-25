//
//  ForeignBird.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

/// 물가를 기준하는 새
struct ForeignBird: BirdModel {
  private let country: CountryProfile
  private let judgmentCriteria: CountryAverageJudgment

  init(
    country: CountryProfile,
    judgment: CountryAverageJudgment
  ) {
    self.country = country
    self.judgmentCriteria = judgment
  }
  
  var criteriaName: String { return judgmentCriteria.name }
  var judgment: Bool { return judgmentCriteria.result == .buying }
  
  var name: String { return "\(country.name) 10년차" }
  var information: String { return "나는 \(country.name) 10년 차 짹짹이야! 베트남의 평균물가를 기준으로 너의 지출들을 판단해줄게!" }
  
  private var birdReaction: BirdReaction {
    // TODO: - 기준 미정
    return .mediumYes
  }
  
  var opinion: String {
    // TODO: - 미정
    switch birdReaction {
    default: return "너무 비싼데..? 정말 필요해?"
    }
  }
  
  var detail: String {
    // TODO: - 미정
    switch birdReaction {
    default: return "일반적인 베트남의 식당 가격보다\n약 40,000동 비싸요!\n하지만 캐쥬얼다이닝의 가격과 비교하면\n약 50,000동 저렴한 편이에요."
    }
  }
}
