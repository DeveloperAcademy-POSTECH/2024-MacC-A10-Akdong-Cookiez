//
//  JudgmentRepositoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/16/24.
//

import Foundation

// MARK: - 이오가 만들어줄 거야
struct JudgmentRepositoryImp: JudgmentRepository {
  /// 해외 모든 국가 데이터를 반환하는 메서드
  func fetchAllCountriesDetails() -> Result<[CountryDetail], Error> {
    return .success([])
  }
  /// 로컬(한국) 기준 데이터를 반환하는 메서드
  func fetchLocalDetails() -> Result<CountryDetail, Error> {
    let mock = CountryDetail(
      country: .init(
        name: "",
        currency: .init(
          unitTitle: "",
          unit: 0
        )
      ),
      items: []
    )
    return .success(mock)
  }
}
