//
//  GuideUseCase.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import Foundation

protocol GuideUseCase {
  /// 최초 실행 시 국가 이름 리스트와 선택된 국가 정보를 불러오는 메서드
  /// (없다면 첫 나라 정보로 자동 배정)
  func getGuideInfo() async -> Result<([String], CountryDetail), Error>
  /// 나라 변경 후 필요한 정보를 받는 메서드
  func getNewGuideInfo(newCountryName selectedCountryName: String) async -> Result<([String], CountryDetail), Error>
}
