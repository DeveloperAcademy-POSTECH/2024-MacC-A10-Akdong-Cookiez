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
        .init(country: .init(name: "베트남", currency: .init(unitTitle: "동", unit: 0.055)), items: [
          Item(category: "카테고리1", name: "품목1-1", amount: 10_000),
          Item(category: "카테고리1", name: "품목1-2", amount: 20_000),
          Item(category: "카테고리1", name: "품목1-3", amount: 30_000),
          Item(category: "카테고리2", name: "품목2-1", amount: 100_000),
          Item(category: "카테고리2", name: "품목2-2", amount: 200_000),
          Item(category: "카테고리3", name: "품목3-1", amount: 1_200_000),
          Item(category: "카테고리3", name: "품목3-2", amount: 2_200_000)
        ])
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
