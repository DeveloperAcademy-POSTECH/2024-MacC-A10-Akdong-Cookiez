//
//  JudgmentUseCaseMock.swift
//  AKCOO
//
//  Created by 박혜운 on 11/16/24.
//

import Foundation

class JudgmentUseCaseMock: JudgmentUseCase {
  private let judgmentRepository: JudgmentRepository
  private let recordRepository: RecordRepository
  
  private var countriesDetails: [CountryDetail]?
  private var localCountryDetail: CountryDetail?
  private var selectedCountryDetail: CountryDetail?
  
  init(
    judgmentRepository: JudgmentRepository = JudgmentRepositoryMock(),
    recordRepository: RecordRepository = RecordRepositoryMock()
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
  
  func getPaperModel(selectedCountryDetail: CountryDetail) -> Result<PaperModel, Error> {
    // 선택된 국가를 RecordRepository에서 가져오기
    guard let countriesDetails else { return .failure(NetworkError()) }

    let selectedCategories = selectedCountryDetail.categories
    let paperModel = PaperModel(
      selectedCountryProfile: CountryProfile.init(name: selectedCountryDetail.name, currency: selectedCountryDetail.currency),
      categories: selectedCategories
    )
    
    return .success(paperModel)
  }
  
  func isPreviousRecordExists(for country: String, category: String) -> Bool {
    return false 
  }
  
  func getBirdsJudgment(selectedCountryDetail: CountryDetail, userQuestion: UserQuestion) -> Result<[BirdModel], Error> {
    guard let localCountryDetail else { return .failure(NetworkError()) }
    let previousResult = recordRepository.fetchPreviousDaySpending(country: userQuestion.country.name, category: userQuestion.category)
    guard case .success(let previousRecord) = previousResult else { return .failure(NetworkError()) }

    let country = CountryProfile(name: selectedCountryDetail.name, currency: selectedCountryDetail.currency)
    let userQuestionAmount = userQuestion.amount
    
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
        birdCountry: country,
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
