//
//  JudgmentRepository.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

protocol JudgmentRepository {
  /// 해외 모든 국가 데이터를 반환하는 메서드
  func fetchAllCountriesDetails() async -> Result<[CountryDetail], Error>
  /// 로컬(한국) 기준 데이터를 반환하는 메서드
  func fetchLocalDetails() async -> Result<CountryDetail, Error>
}
