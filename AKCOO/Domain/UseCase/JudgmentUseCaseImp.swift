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
  
  init(
    judgmentRepository: JudgmentRepository,
    recordRepository: RecordRepository
  ) {
    self.judgmentRepository = judgmentRepository
    self.recordRepository = recordRepository
  }
  
  func getPaperModel(selectedCountryDetail: CountryDetail) -> Result<PaperModel, Error> {
    let selectedCategories = selectedCountryDetail.categories
    let paperModel = PaperModel(
      selectedCountryProfile: .init(name: selectedCountryDetail.name, currency: selectedCountryDetail.currency),
      categories: selectedCategories
    )
    
    return .success(paperModel)
  }
  
  func isPreviousRecordExists(for country: String, category: String) -> Bool {
    var result = false
    if case .success(let previousRecord) = recordRepository.fetchPreviousDaySpending(country: country, category: category) {
      result = previousRecord != nil
    }
    return result
  }
  
  func getBirdsJudgment(selectedCountryDetail: CountryDetail, userQuestion: UserQuestion) async -> Result<[BirdModel], Error> {
    let previousResult = recordRepository.fetchPreviousDaySpending(country: userQuestion.country.name, category: userQuestion.category)
    guard case .success(let previousRecord) = previousResult else { return .failure(NetworkError()) }
    
    let localCountryDetail: CountryDetail
    switch await judgmentRepository.fetchLocalDetails() {
    case .success(let countryDetail): localCountryDetail = countryDetail
    case .failure(let error): return .failure(error) // 실패 시 처리
    }
    
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
      standards: previousRecord
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
}
