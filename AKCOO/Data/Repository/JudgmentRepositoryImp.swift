//
//  JudgmentRepositoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/16/24.
//

import FirebaseFirestore
import Foundation

// MARK: - 이오가 만들어줄 거야
struct JudgmentRepositoryImp: JudgmentRepository {
  private let firestore = FirestoreService()
  
  func fetchAllCountriesDetails() async -> Result<[CountryDetail], Error> {
    do {
      // 국가 목록 가져오기
      let countries = try await firestore.getAllCountries().get()
      var countryDetails: [CountryDetail] = []
      for country in countries.filter({ $0.contains("korea") == false }) {
        let detail = try await fetchCountryDetail(at: country).get()
        countryDetails.append(detail)
      }
      
      // 성공
      print("🍀 DEBUG(SUCCESS): Firestore에서 모든 나라 정보 가져오기 성공 \(countryDetails)")
      return .success(countryDetails)
    } catch {
      print("🚨 DEBUG(ERROR): Firestore에서 모든 나라 정보 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
  
  /// 로컬(한국) 기준 데이터를 반환하는 메서드
  func fetchLocalDetails() async -> Result<CountryDetail, Error> {
    do {
      let detail = try await fetchCountryDetail(at: "korea").get()
      return .success(detail)
    } catch {
      print("🚨 DEBUG(ERROR): Firestore에서 한국 정보 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
}

/// 해외 모든 국가 데이터를 반환하는 메서드
extension JudgmentRepositoryImp {
  // 국가 정보(환율 + 물가) 가져오기
  private func fetchCountryDetail(at country: String) async -> Result<CountryDetail, Error> {
    do {
      // 국가별 환율 정보 가져오기
      let countryProfile = try await fetchCountryProfile(at: country).get()
      
      // 국가별 물가 정보 가져오기
      let items = try await fetchItems(at: country).get()
      
      // 국가별 정보 종합하기
      let detail = CountryDetail(
        country: countryProfile,
        items: items
      )
      
      return .success(detail)
    } catch {
      return .failure(error)
    }
  }
  
  // 국가별 환율 정보 가져오기
  private func fetchCountryProfile(at country: String) async -> Result<CountryProfile, Error> {
    switch await firestore.getExchangeRate(at: country) {
    case .success(let exchangeRateInfo):
      // 환율 정보
      let currency = Currency(
        unitTitle: exchangeRateInfo.unitTitle,
        unit: exchangeRateInfo.unit
      )
      
      // 나라 정보
      let profile = CountryProfile(
        name: exchangeRateInfo.name,
        currency: currency
      )
      
      return .success(profile)
    case .failure(let error):
      return .failure(error)
    }
  }
  
  // 국가별 물가 정보 가져오기
  private func fetchItems(at country: String) async -> Result<[Item], Error> {
    switch await firestore.getPrices(at: country) {
    case .success(let prices):
      // 물가 기준들
      let items: [Item] = prices.compactMap { price in
        let item = Item(
          category: price.category,
          name: price.item,
          amount: price.price
        )
        
        return item
      }
      return .success(items)
    case .failure(let error):
      return .failure(error)
    }
  }
}
