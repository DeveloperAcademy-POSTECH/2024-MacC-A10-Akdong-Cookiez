//
//  JudgmentRepositoryMock.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

struct JudgmentRepositoryMock: JudgmentRepository {
  /// 해외 모든 국가 데이터를 반환하는 메서드
  func fetchAllCountriesDetails() -> Result<[CountryDetail], Error> {
    let vietnamProfile = CountryProfile.init(name: "베트남", currency: .init(unitTitle: "동", unit: 0.055))
    let swissProfile = CountryProfile.init(name: "스위스", currency: .init(unitTitle: "프랑", unit: 1579.93))
    let vietnamItems = [
      Item(category: "숙소", name: "게스트하우스", amount: 735_000),
      Item(category: "숙소", name: "3성급", amount: 1_300_000),
      Item(category: "숙소", name: "4성급", amount: 2_500_000),
      
      Item(category: "식당", name: "로컬식당", amount: 55_000),
      Item(category: "식당", name: "캐주얼다이닝", amount: 120_000),
      
      Item(category: "카페", name: "로컬카페", amount: 30_000),
      Item(category: "카페", name: "하이랜드커피", amount: 45_000)
    ]
    
    let swissItems = [
      Item(category: "숙소", name: "게스트하우스", amount: 100),
      Item(category: "숙소", name: "3성급", amount: 250),
      Item(category: "숙소", name: "4성급", amount: 350),
      
      Item(category: "식당", name: "로컬식당", amount: 25),
      Item(category: "식당", name: "캐주얼다이닝", amount: 55),
      
      Item(category: "카페", name: "로컬카페", amount: 4.5),
      Item(category: "카페", name: "스타벅스", amount: 5.9)
    ]
    
    let vetnam = CountryDetail(
      country: vietnamProfile,
      items: vietnamItems
    )
    let swiss = CountryDetail(
      country: swissProfile,
      items: swissItems
    )
    return .success([vetnam, swiss])
  }
  
  /// 로컬(한국) 기준 데이터를 반환하는 메서드
  func fetchLocalDetails() -> Result<CountryDetail, Error> {
    let koreaProfile = CountryProfile.init(name: "대한민국", currency: .init(unitTitle: "원", unit: 1))
    let koreaItems = [
      Item(category: "숙소", name: "게스트하우스", amount: 50_000),
      Item(category: "숙소", name: "3성급", amount: 150_000),
      Item(category: "숙소", name: "4성급", amount: 250_000),
      
      Item(category: "식당", name: "로컬식당", amount: 8_800),
      Item(category: "식당", name: "캐주얼다이닝", amount: 24_000),
      
      Item(category: "카페", name: "로컬카페", amount: 3_500),
      Item(category: "카페", name: "스타벅스", amount: 4_500)
    ]
    
    let korea = CountryDetail(
      country: koreaProfile,
      items: koreaItems
    )

    return .success(korea)
  }
}
