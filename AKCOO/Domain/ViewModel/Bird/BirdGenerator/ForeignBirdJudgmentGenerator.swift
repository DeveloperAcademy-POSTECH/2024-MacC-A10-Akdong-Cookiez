//
//  ForeignBirdJudgmentGenerator.swift
//  AKCOO
//
//  Created by Anjin on 11/25/24.
//

import Foundation

struct ForeignBirdJudgmentGenerator: BirdJudgmentGenerator {
  func getOpinion(judgmentCriteria: CountryAverageJudgment, reaction: BirdReaction) -> String {
    let category = judgmentCriteria.standards.first?.category
    
    switch reaction {
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
}
