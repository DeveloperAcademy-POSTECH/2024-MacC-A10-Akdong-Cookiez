//
//  PriceResponseDTO.swift
//  AKCOO
//
//  Created by Anjin on 11/20/24.
//

import Foundation

/// Firestore - 나라별 물가 정보를 가져오는 DTO
struct PriceResponseDTO: Decodable {
  let category: String
  let item: String
  let price: Double
}
