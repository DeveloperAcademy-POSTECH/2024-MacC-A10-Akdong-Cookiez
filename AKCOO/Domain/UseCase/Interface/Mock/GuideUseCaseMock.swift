//
//  GuideUseCaseMock.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import Foundation

struct GuideUseCaseMock: GuideUseCase {
  func getGuideInfo() async -> Result<([String], CountryDetail), any Error> {
    .success(
      (
        ["스위스", "베트남"],
        .init(country: .init(name: "베트남", currency: .init(unitTitle: "동", unit: 0.059)), items: [])
      )
    )
  }
  
  func getNewGuideInfo(newCountryName selectedCountryName: String) async -> Result<([String], CountryDetail), any Error> {
    return await getGuideInfo()
  }
  
  func getCountryNames() -> Result<[String], any Error> {
    return .success(["베트남", "스위스"])
  }
  
  func getCountryDetail() -> Result<CountryDetail, any Error> {
    return .success(.init(country: .init(name: "베트남", currency: .init(unitTitle: "동", unit: 0.059)), items: []))
  }
  
  func getNewCountryDetail(newCountryName selectedCountryName: String) -> Result<CountryDetail, any Error> {
    return .success(.init(country: .init(name: "베트남", currency: .init(unitTitle: "동", unit: 0.059)), items: []))
  }
}
