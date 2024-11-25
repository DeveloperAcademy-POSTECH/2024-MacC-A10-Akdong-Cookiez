//
//  LocalBirdJudgmentGenerator+getOpinion.swift
//  AKCOO
//
//  Created by Anjin on 11/25/24.
//

import Foundation

extension LocalBirdJudgmentGenerator {
  func getOpinion(judgmentCriteria: CountryAverageJudgment, reaction: BirdReaction) -> String {
    let category = judgmentCriteria.standards.first?.category
    
    switch reaction {
    case .strongYes:
      return "한국에서는 볼 수 없는 가격이야"
      
    case .mediumYes:
      return "한국에서도 저렴한 가격이야"
      
    case .weakYes:
      return "안 사면 한국 가서 후회할걸?"
      
    case .weakNo:
      return "한국보다 조금 비싼 편이야"
      
    case .mediumNo:
      if let category {
        return "차라리 한국에서 \(category) 어때?"
      } else {
        return "차라리 한국에서 소비해"
      }
      
    case .strongNo:
      if let category {
        return "너무 비싸! 다른 \(category) 찾아봐"
      } else {
        return "너무 비싸! 다른 걸 찾아봐"
      }
    }
  }
}
