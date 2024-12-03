//
//  LocalBirdJudgmentGenerator.swift
//  AKCOO
//
//  Created by Anjin on 11/25/24.
//

import Foundation

struct LocalBirdJudgmentGenerator: BirdJudgmentGenerator {
  func getOpinion(judgmentCriteria: CountryAverageJudgment, reaction: BirdReaction) -> String {
    let category = judgmentCriteria.standards.first?.category
    
    switch reaction {
    case .strongYes:
      return BirdConstants.LocalBirdOpinion.strongYes
      
    case .mediumYes:
      return BirdConstants.LocalBirdOpinion.mediumYes
      
    case .weakYes:
      return BirdConstants.LocalBirdOpinion.weakYes
      
    case .weakNo:
      return BirdConstants.LocalBirdOpinion.weakNo
      
    case .mediumNo:
      if let category {
        return BirdConstants.LocalBirdOpinion.mediumNoWithCategory
          .fillTemplate(with: category == "숙소" ? "호캉스": category)
      } else {
        return BirdConstants.LocalBirdOpinion.mediumNo
      }
      
    case .strongNo:
      if let category {
        return BirdConstants.LocalBirdOpinion.strongNoWithCategory
          .fillTemplate(with: category)
      } else {
        return BirdConstants.LocalBirdOpinion.strongNo
      }
    }
  }
}
