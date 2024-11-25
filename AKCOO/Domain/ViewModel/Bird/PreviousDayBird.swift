//
//  PreviousDayBird.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

/// 직전 소비를 기준하는 새
struct PreviousDayBird: BirdModel {
  private let judgmentCriteria: PreviousJudgment
  
  init(judgment: PreviousJudgment) {
    self.judgmentCriteria = judgment
  }
  
  var judgment: Bool { return judgmentCriteria.result == .buying }

  private var birdReaction: BirdReaction { return .mediumNo }
  
  var name: String { "지난 날의 나" }
  var information: String { return "직전 소비로만 판단해!" }
  
  // TODO: - 내용작성
  var opinion: String {
    switch birdReaction {
    default: return "너무 비싼데..? 정말 필요해?"
    }
  }
  
  var detail: String {
    // 선택된 카테고리와 서브 카테고리의 평균 금액을 기준으로 세부 설명 작성
    switch birdReaction {
    default: return "일반적인 베트남의 식당 가격보다\n약 40,000동 비싸요!\n하지만 캐쥬얼다이닝의 가격과 비교하면\n약 50,000동 저렴한 편이에요."
    }
  }
}
