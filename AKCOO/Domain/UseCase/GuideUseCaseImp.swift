//
//  GuideUseCaseImp.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import Foundation

class GuideUseCaseImp: GuideUseCase {
  private let judgmentRepository: JudgmentRepository
  private let recordRepository: RecordRepository
  
  private var countriesDetails: [CountryDetail]?
  private var selectedCountryDetail: CountryDetail?
  
  init(
    judgmentRepository: JudgmentRepository,
    recordRepository: RecordRepository
  ) {
    self.judgmentRepository = judgmentRepository
    self.recordRepository = recordRepository
  }
  
  func getGuideInfo() async -> Result<([String], CountryDetail), Error> {
    
    let tmpCountriesDetails: [CountryDetail]
    let tmpSelectedCountryDetail: CountryDetail
    let countriesName: [String]
    
    if let countriesDetails, let selectedCountryDetail {
      tmpCountriesDetails = countriesDetails
      tmpSelectedCountryDetail = selectedCountryDetail
    } else {
      let allCountriesDetailsResult = await judgmentRepository.fetchAllCountriesDetails()
      switch allCountriesDetailsResult {
      case .success(let countriesDetails):
        self.countriesDetails = countriesDetails
        tmpCountriesDetails = countriesDetails
      case .failure(let error): return .failure(error)
      }
      
      let selectedCountryResult = recordRepository.fetchSelectedCountry()
      switch selectedCountryResult {
      case .success(let selectedCountryName):
        if let selectedCountryName, let selectedCountryDetail = tmpCountriesDetails.filter({ $0.name == selectedCountryName }).first {
          tmpSelectedCountryDetail = selectedCountryDetail
        } else if let firstDetails = tmpCountriesDetails.first {
          tmpSelectedCountryDetail = firstDetails
        } else {
          tmpSelectedCountryDetail = .init(country: .init(name: "", currency: .init(unitTitle: "", unit: 0)), items: [])
          print("CountriesDetails이 없습니다")
        }
      case .failure(let error): return .failure(error)
      }
    }
    
    self.countriesDetails = tmpCountriesDetails
    self.selectedCountryDetail = tmpSelectedCountryDetail
    
    countriesName = tmpCountriesDetails.map { $0.name }
    
    return .success((countriesName, tmpSelectedCountryDetail))
  }
  
  func getNewGuideInfo(newCountryName selectedCountryName: String) async -> Result<([String], CountryDetail), Error> {
    guard
      let countriesDetails,
      let newSelectedCountryDetail = countriesDetails.filter({ $0.name == selectedCountryName }).first else { return .failure(NetworkError()) }

    _ = recordRepository.saveSelectedCountry(selectedCountryName)
    selectedCountryDetail = newSelectedCountryDetail
    
    return await getGuideInfo()
  }
}
