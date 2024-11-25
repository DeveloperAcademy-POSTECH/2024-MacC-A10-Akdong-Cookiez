//
//  BirdJudgmentGenerator.swift
//  AKCOO
//
//  Created by Anjin on 11/25/24.
//

import Foundation

protocol BirdJudgmentGenerator {
  func getReaction(judgmentCriteria: CountryAverageJudgment) -> BirdReaction
  func getOpinion(judgmentCriteria: CountryAverageJudgment, reaction: BirdReaction) -> String
  func getDetail(country: CountryProfile, judgmentCriteria: CountryAverageJudgment) -> String
}
