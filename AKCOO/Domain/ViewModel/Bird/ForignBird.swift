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

  init(
    country: CountryProfile,
    judgment: CountryAverageJudgment
  ) {
    self.country = country
    self.judgmentCriteria = judgment
  }
  
  var judgment: Bool { return judgmentCriteria.result == .buying }
  
  var name: String { return "\(country.name) 10년차" }
  var information: String { return "나는 \(country.name) 10년 차 짹짹이야! 베트남의 평균물가를 기준으로 너의 지출들을 판단해줄게!" }
  
  private var birdReaction: BirdReaction {
    // TODO: - 기준 미정
    return .mediumYes
  }
  
  var opinion: String {
    let category = judgmentCriteria.standards.first?.category
    
    switch birdReaction {
    case .strongYes:
      if let category, ["숙박", "식당", "카페"].contains(category) {
        // 카테고리가 숙박, 식당, 카페인 경우
        return "뭘 고민해! 무조건 가야지"
      } else {
        // 카테고리가 기타이거나 없는 경우
        return "뭘 고민해! 무조건 소비해"
      }
      
    case .mediumYes:
      return "이 가격이면 나쁘지 않아"
      
    case .weakYes:
      return "현지에서도 저렴한 금액이야"
      
    case .weakNo:
      return "음.. 조금 비싼데!?"
      
    case .mediumNo:
      return "음.. 꽤 비싼 편이야"
      
    case .strongNo:
      if let category {
        return "너무 비싸! 다른 \(category) 찾아봐"
      } else {
        return "너무 비싸! 다른 걸 찾아봐"
      }
    }
  }
  
  var detail: String {
    // TODO: - 미정
    switch birdReaction {
    default: return "너무 비싼데..? 정말 필요해?"
    }
  }
}
