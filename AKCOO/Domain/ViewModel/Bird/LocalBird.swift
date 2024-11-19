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
  private let judgment: CountryAverageJudgment
  
  init(
    country: CountryProfile,
    judgment: CountryAverageJudgment
  ) {
    self.country = country
    self.judgment = judgment
  }
  
  private var birdReaction: BirdReaction {
    return .mediumNo
  }
  
  var name: String { return "대한민국 토박이" }
  var information: String { return "나는 한국 토박이야!" }
  
  var opinion: String {
    switch birdReaction {
    default: return "너무 비싼데..? 정말 필요해?"
    }
  }
  
  var detail: String {
    // 선택된 카테고리와 서브 카테고리의 평균 금액을 기준으로 세부 설명 작성
    switch birdReaction {
    default: return "너무 비싼데..? 정말 필요해?"
    }
  }
}
