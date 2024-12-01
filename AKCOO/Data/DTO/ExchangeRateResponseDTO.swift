//
//  ExchangeRateResponseDTO.swift
//  AKCOO
//
//  Created by Anjin on 11/20/24.
//

import Foundation

/// Firestore - 나라별 환율 정보를 가져오는 DTO
struct ExchangeRateResponseDTO: Decodable {
  let name: String
  let unit: Double
  let unitTitle: String
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case unitTitle = "unit"
    case unit = "exchangeRate"
  }
}
