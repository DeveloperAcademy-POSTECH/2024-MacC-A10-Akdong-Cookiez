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
      return .success(countries)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Firestore에서 나라 목록 가져오기 실패 \(error)")
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
      return .success(exchangeRateInfo)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Firestore에서 특정 나라(\(country))의 환율 정보 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
  
  /// Firestore: 특정 나라의 물가 정보 가져오기
  func getPrices(at country: String) async -> Result<[PriceResponseDTO], Error> {
    do {
      let countriesCollection = db.collection(FirestoreConstants.Collections.countries)
      let countryDocument = countriesCollection.document(country)
      let pricesCollection = countryDocument.collection(FirestoreConstants.Collections.prices)
      let pricesDocuments = try await pricesCollection.getDocuments()
      
      let prices: [PriceResponseDTO] = try pricesDocuments.documents
        .compactMap { document in
          try document.data(as: PriceResponseDTO.self)
      }
      
      // 성공
      return .success(prices)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Firestore에서 특정 나라(\(country))의 물가 정보 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
}
