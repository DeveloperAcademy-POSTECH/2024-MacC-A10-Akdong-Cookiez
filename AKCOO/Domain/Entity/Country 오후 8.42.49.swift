//
//  Country.swift
//  AKCOO
//
//  Created by 박혜운 on 11/7/24.
//

import Foundation

struct Country: Identifiable {
  let id: String = UUID.init().uuidString
  var name: String                 // 국가명
  var currency: Currency           // 통화
  var criteria: CountryCriterion   // 카테고리 금액 기준정보
}
