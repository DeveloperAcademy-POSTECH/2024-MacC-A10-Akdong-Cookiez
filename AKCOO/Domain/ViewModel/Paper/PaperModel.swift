//
//  PaperModel.swift
//  AKCOO
//
//  Created by 박혜운 on 11/16/24.
//

import Foundation

/// 재판요청서를 보이기 위해 화면에 필요한 값
struct PaperModel {
  var selectedCountry: String        // 선택된 국가
  var countries: [CountryProfile]    // 국가 리스트
  var categories: [String]           // 선택된 국가 카테고리 정보
}
