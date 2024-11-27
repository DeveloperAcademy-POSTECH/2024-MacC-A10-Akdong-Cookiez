//
//  JudgmentUseCaseImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

class JudgmentUseCaseImp: JudgmentUseCase {
  private let judgmentRepository: JudgmentRepository
  private let recordRepository: RecordRepository
  
  private var countriesDetails: [CountryDetail]?
  private var localCountryDetail: CountryDetail?
  private var selectedCountryDetail: CountryDetail?
  
  init(
    judgmentRepository: JudgmentRepository,
    recordRepository: RecordRepository
  ) {
    self.judgmentRepository = judgmentRepository
    self.recordRepository = recordRepository
    
    Task {
      let tmpCountriesDetails: [CountryDetail]
      switch await judgmentRepository.fetchAllCountriesDetails() {
      case .success(let countriesDetails):
        self.countriesDetails = countriesDetails
        tmpCountriesDetails = countriesDetails
      case .failure: return // 실패 시 처리
      }
      
      switch await judgmentRepository.fetchLocalDetails() {
      case .success(let localDetail):
        self.localCountryDetail = localDetail
      case .failure: return // 실패 시 처리
      }
      
      switch recordRepository.fetchSelectedCountry() {
      case .success(let selectedCountryName):
        if let selectedCountryName {
          self.selectedCountryDetail = tmpCountriesDetails.filter({ $0.name == selectedCountryName }).first
        } else if let firstDetails = tmpCountriesDetails.first {
          self.selectedCountryDetail = firstDetails
        } else {
          print("CountriesDetails이 없습니다")
        }
      case .failure: return
      }
    }
  }
  
  func getPaperModel() -> Result<PaperModel, Error> {
    // 선택된 국가를 RecordRepository에서 가져오기
    guard let countriesDetails else { return .failure(NetworkError()) }
    guard let selectedCountryDetail else { return .failure(NetworkError()) }

    let countryProfiles = getCountryProfiles(to: countriesDetails)
    let countryNames = countryProfiles.map { $0.name }
    let selectedCategories = selectedCountryDetail.categories
    let paperModel = PaperModel(
      selectedCountryProfile: .init(name: selectedCountryDetail.name, currency: selectedCountryDetail.currency),
      countries: countryNames,
      categories: selectedCategories
    )
    
    return .success(paperModel)
  }
  
  // TODO: - 이오 확인
  func getNewPaperModel(newCountryName selectedCountryName: String) -> Result<PaperModel, any Error> {
    guard let countriesDetails,
          let newSelectedCountryDetail = countriesDetails.filter({ $0.name == selectedCountryName }).first else { return .failure(NetworkError()) }
    // TODO: - RecordRepository를 통해 선택된 국가를 변경하는 로직 추가
    selectedCountryDetail = newSelectedCountryDetail
    
    return getPaperModel()
  }
  
  func getBirdsJudgment(userQuestion: UserQuestion) -> Result<[BirdModel], Error> {
    guard let selectedCountryDetail else { return .failure(NetworkError()) }
    guard let localCountryDetail else { return .failure(NetworkError()) }
    let previousResult = recordRepository.fetchPreviousDaySpending(country: userQuestion.country.name, category: userQuestion.category)
    guard case .success(let previousRecord) = previousResult else { return .failure(NetworkError()) }
    
    let localCountry = CountryProfile(
      name: localCountryDetail.name,
      currency: localCountryDetail.currency
    )
    let forignJudgment = CountryAverageJudgment(
      userQuestion: userQuestion,
      standards: selectedCountryDetail.items
    )
    let localJudgment = CountryAverageJudgment(
      userQuestion: userQuestion,
      standards: localCountryDetail.items
    )
    
    let previousJudgment = PreviousJudgment(
      userQuestion: userQuestion,
      standards: nil
    )
    
    let birds: [BirdModel] = [
      ForeignBird(judgment: forignJudgment),
      LocalBird(
        birdCountry: localCountry,
        judgment: localJudgment
      ),
      PreviousBird(judgment: previousJudgment)
    ]
    
    return .success(birds)
  }
  
  func save(record: UserRecord) -> Result<VoidResponse, any Error> {
    return recordRepository.saveRecord(record: record)
  }
  
  // MARK: - Private Methods
  private func getCountryProfiles(to countriesDetails: [CountryDetail]) -> [CountryProfile] {
    return countriesDetails.map { CountryProfile(name: $0.name, currency: $0.currency) }
  }
}
