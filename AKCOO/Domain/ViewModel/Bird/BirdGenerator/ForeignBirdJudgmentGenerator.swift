//
//  ForeignBirdJudgmentGenerator.swift
//  AKCOO
//
//  Created by Anjin on 11/25/24.
//

import Foundation

struct ForeignBirdJudgmentGenerator: BirdJudgmentGenerator {
  // FIXME: parameter로 category를 직접 대입
  func getOpinion(judgmentCriteria: CountryAverageJudgment, reaction: BirdReaction) -> String {
    let category = judgmentCriteria.standards.first?.category
    
    switch reaction {
    case .strongYes:
      if let category, ["숙소", "식당", "카페"].contains(category) {
        // 카테고리가 숙소, 식당, 카페인 경우
        return BirdConstants.ForeignBirdOpinion.strongYesWith숙소식당카페
      } else {
        // 카테고리가 기타이거나 없는 경우
        return BirdConstants.ForeignBirdOpinion.strongYes
      }
      
    case .mediumYes:
      return BirdConstants.ForeignBirdOpinion.mediumYes
      
    case .weakYes:
      return BirdConstants.ForeignBirdOpinion.weakYes
      
    case .weakNo:
      return BirdConstants.ForeignBirdOpinion.weakNo
      
    case .mediumNo:
      return BirdConstants.ForeignBirdOpinion.mediumNo
      
    case .strongNo:
      if let category {
        return BirdConstants.ForeignBirdOpinion
          .strongNoWithCategory
          .fillTemplate(with: category)
      } else {
        return BirdConstants.ForeignBirdOpinion.strongNo
      }
    }
  }
}
