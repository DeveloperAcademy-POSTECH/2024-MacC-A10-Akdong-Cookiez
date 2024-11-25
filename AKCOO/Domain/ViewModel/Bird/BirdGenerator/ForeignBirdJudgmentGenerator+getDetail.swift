//
//  ForeignBirdJudgmentGenerator+getDetail.swift
//  AKCOO
//
//  Created by Anjin on 11/25/24.
//

import Foundation

/// 판단에 대한 상세 내용
extension ForeignBirdJudgmentGenerator {
  func getDetail(country: CountryProfile, judgmentCriteria: CountryAverageJudgment) -> String {
    var result = ""
    
    result += getDetailAboutAverage(
      country: country,
      judgmentCriteria: judgmentCriteria
    )
    
    result += getDetailAboutExtraStandard(
      country: country,
      judgmentCriteria: judgmentCriteria
    )
    
    return result
  }
  
  /// 평균 가격에 대한 상세 내용
  private func getDetailAboutAverage(country: CountryProfile, judgmentCriteria: CountryAverageJudgment) -> String {
    // 나라 정보
    let countryName = country.name
    let countryUnitTitle = country.currency.unitTitle
    
    // 입력 정보
    let category = judgmentCriteria.standards.first?.category ?? ""
    
    // 평균과의 차이
    let differenceWithAverage = judgmentCriteria.userAmount - (judgmentCriteria.averageOfItems ?? 0.0)
    let absoluteDifference = abs(differenceWithAverage)
    
    // 평균 가격에 대한 상세 내용
    var result = "일반적인 \(countryName)의 \(category) 가격"
    
    switch differenceWithAverage {
    case ..<0: // 입력 금액 < 평균
      result += "보다\n약 \(absoluteDifference)\(countryUnitTitle) 저렴해요!"
    case 0:    // 입력 금액 == 평균
      result += "과 같아요!"
    case 0...: // 입력 금액 > 평균
      result += "보다\n약 \(absoluteDifference)\(countryUnitTitle) 저렴해요!"
    default:   // 기본
      result += "은\n약 \(judgmentCriteria.averageOfItems ?? 0.0)\(countryUnitTitle) 입니다."
    }
    
    return result
  }
  
  /// 입력 금액과 가장 가까운 기준에 대한 상세 내용
  private func getDetailAboutExtraStandard(country: CountryProfile, judgmentCriteria: CountryAverageJudgment) -> String {
    // 나라 정보
    let countryUnitTitle = country.currency.unitTitle
    
    // 입력 정보
    let userAmount = judgmentCriteria.userAmount
    
    // 판단 정보
    let isJudgmentBuying = judgmentCriteria.result == .buying
    
    // 입력 정보와 가장 가까운 기준
    let closestItem = judgmentCriteria.standards.min(by: {
      abs($0.amount - userAmount) < abs($1.amount - userAmount)
    })
    let differenceWithClosestItem = judgmentCriteria.userAmount - (closestItem?.amount ?? 0.0)
    
    // 입력 금액과 가장 가까운 기준 가격에 대한 상세 내용
    var result = ""
    if isJudgmentBuying ? differenceWithClosestItem <= 0 : differenceWithClosestItem > 0 {
      // (입력 금액 <= 평균) && (입력 금액 <= 가까운 기준값)
      // (입력 금액 > 평균) && (입력 금액 > 가까운 기준값)
      result += "그리고 "
    } else {
      result += "하지만 "
    }
    
    result += "\(closestItem?.name ?? "")의 "
    
    let absoluteDifferenceWithClosest = abs(differenceWithClosestItem)
    switch differenceWithClosestItem {
    case ..<0: // 입력 금액 < 가까운 값
      result += "가격과 비교하면\n약 \(absoluteDifferenceWithClosest)\(countryUnitTitle) 저렴한 편이에요."
    case 0:    // 입력 금액 == 가까운 값
      result += "가격과 같아요."
    case 0...: // 입력 금액 > 가까운 값
      result += "가격과 비교하면\n약 \(absoluteDifferenceWithClosest)\(countryUnitTitle) 비싼 편이에요."
    default:   // 기본
      result += "가격은 \(closestItem?.amount ?? 0.0)\(countryUnitTitle) 이에요."
    }
    
    return result
  }
}
