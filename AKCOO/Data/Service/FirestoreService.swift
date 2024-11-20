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
  
  /// Firestore: 나라별 환율 정보 가져오기
  func getAllCountriesExchangeRate() async -> Result<[ExchangeRateResponseDTO], Error> {
    do {
      // Firestore가 가지고 있는 나라 목록
      let countries = try await getAllCountries().get()
      let countriesCollection = db.collection(FirestoreConstants.Collections.countries)
      
      // 나라별 환율 데이터 가져오기
      var exchangeRateInfos: [ExchangeRateResponseDTO] = []
      for country in countries {
        let document = countriesCollection.document(country)
        let exchangeRateInfo = try await document.getDocument(as: ExchangeRateResponseDTO.self)
        exchangeRateInfos.append(exchangeRateInfo)
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
}

