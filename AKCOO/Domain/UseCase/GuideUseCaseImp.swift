//
//  GuideUseCaseImp.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import Foundation

struct GuideUseCaseImp: GuideUseCase {
  func getCountryNames() -> Result<[String], any Error> {
    return .failure(NetworkError())
  }
  
  func getCountryDetail() -> Result<CountryDetail, any Error> {
    return .failure(NetworkError())
  }
  
  func getNewCountryDetail(newCountryName selectedCountryName: String) -> Result<CountryDetail, any Error> {
    return .failure(NetworkError())
  }
}
