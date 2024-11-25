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
    let swissProfile = CountryProfile.init(name: "스위스", currency: .init(unitTitle: "프랑", unit: 1575.64))
    let vietnamItems = [
      Item(category: "숙박베", name: "품목1", amount: 100000),
      Item(category: "식당베", name: "품목2", amount: 200000),
      Item(category: "카페베", name: "품목3", amount: 300000)
    ]
    let swissItems = [
      Item(category: "숙박스", name: "품목1", amount: 100000),
      Item(category: "식당스", name: "품목2", amount: 200000),
      Item(category: "카페스", name: "품목3", amount: 300000)
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
      Item(category: "카테고리1", name: "기준품목1", amount: 100000),
      Item(category: "카테고리2", name: "기준품목2", amount: 200000),
      Item(category: "카테고리3", name: "기준품목3", amount: 300000)
    ]
    
    let korea = CountryDetail(
      country: koreaProfile,
      items: koreaItems
    )

    return .success(korea)
  }
}
