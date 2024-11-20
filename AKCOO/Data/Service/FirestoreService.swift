//
//  FirestoreService.swift
//  AKCOO
//
//  Created by Anjin on 11/20/24.
//

import FirebaseFirestore
import Foundation

struct FirestoreService {
  private let db = Firestore.firestore()
  
  /// Firestore: 나라 목록 가져오기
  func getAllCountries() async -> Result<[String], Error> {
    do {
      // 나라 Collection 가져오기
      let collection = db.collection(FirestoreConstants.Collections.countries)
      let documents = try await collection.getDocuments().documents
      
      // Firestore에 가지고 있는 나라 목록 가져오기
      var countries: [String] = []
      for document in documents {
        countries.append(document.documentID)
      }
      
      // 성공
      print("🍀 DEBUG(SUCCESS): Firestore에서 나라 목록 가져오기 성공 \(countries)")
      return .success(countries)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Firestore에서 나라 목록 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
  
  /// Firestore: 모든 나라의 환율 정보 가져오기
  func getAllCountriesExchangeRate() async -> Result<[String: ExchangeRateResponseDTO], Error> {
    do {
      // Firestore가 가지고 있는 나라 목록
      let countries = try await getAllCountries().get()
      
      // 나라별 환율 데이터 가져오기
      var exchangeRateInfos: [String: ExchangeRateResponseDTO] = [:]
      for country in countries {
        let exchangeRateInfo = try await getExchangeRate(at: country).get()
        exchangeRateInfos[country] = exchangeRateInfo
      }
      
      // 성공
      print("🍀 DEBUG(SUCCESS): Firestore에서 나라별 환율 정보 가져오기 성공 \(exchangeRateInfos)")
      return .success(exchangeRateInfos)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Firestore에서 나라별 환율 정보 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
  
  /// Firestore: 특정 나라의 환율 정보 가져오기
  func getExchangeRate(at country: String) async -> Result<ExchangeRateResponseDTO, Error> {
    do {
      let countriesCollection = db.collection(FirestoreConstants.Collections.countries)
      let countryDocument = countriesCollection.document(country)
      let exchangeRateInfo = try await countryDocument.getDocument(as: ExchangeRateResponseDTO.self)
      
      // 성공
      print("🍀 DEBUG(SUCCESS): Firestore에서 특정 나라(\(country))의 환율 정보 가져오기 성공 \(exchangeRateInfo)")
      return .success(exchangeRateInfo)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Firestore에서 특정 나라(\(country))의 환율 정보 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
  
  /// Firestore: 나라별 물가 정보 가져오기
  func getAllCountriesPrices() async -> Result<[String: PriceResponseDTO], Error> {
    do {
      // Firestore가 가지고 있는 나라 목록
      let countries = try await getAllCountries().get()
      
      
      // 나라별 물가 정보 가져오기
      var countriesPricesInfos: [String: PriceResponseDTO] = [:]
      for country in countries {
        let pricesInfo = try await getPrices(at: country).get()
        countriesPricesInfos[country] = pricesInfo
      }
      
      // 성공
      print("🍀 DEBUG(SUCCESS): Firestore에서 모든 나라의 물가 정보 가져오기 성공 \(countriesPricesInfos)")
      return .success(countriesPricesInfos)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Firestore에서 모든 나라의 물가 정보 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
  
  /// Firestore: 특정 나라의 물가 정보 가져오기
  func getPrices(at country: String) async -> Result<PriceResponseDTO, Error> {
    do {
      let countriesCollection = db.collection(FirestoreConstants.Collections.countries)
      
      let countryDocument = countriesCollection.document(country)
      let pricesCollection = countryDocument.collection(FirestoreConstants.Collections.prices)
      
      // 숙소 Document 가져오기
      let accommodationDocument = pricesCollection.document(FirestoreConstants.Documents.accommodation)
      let accommodationInfo = try await accommodationDocument.getDocument(as: PriceAccommodationDTO.self)
      
      // 카페 Document 가져오기
      let cafeDocument = pricesCollection.document(FirestoreConstants.Documents.cafe)
      let cafeInfo = try await accommodationDocument.getDocument(as: PriceCafeDTO.self)
      
      // 식당 Document 가져오기
      let restaurantDocument = pricesCollection.document(FirestoreConstants.Documents.restaurant)
      let restaurantInfo = try await accommodationDocument.getDocument(as: PriceRestaurantDTO.self)
      
      let pricesInfo = PriceResponseDTO(
        accommodation: accommodationInfo,
        cafe: cafeInfo,
        restaurant: restaurantInfo
      )
      
      // 성공
      print("🍀 DEBUG(SUCCESS): Firestore에서 특정 나라(\(country)의 환율 정보 가져오기 성공 \(pricesInfo)")
      return .success(pricesInfo)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Firestore에서 특정 나라(\(country))의 환율 정보 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
}
