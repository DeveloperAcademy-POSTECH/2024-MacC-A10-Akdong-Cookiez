//
//  PriceResponseDTO.swift
//  AKCOO
//
//  Created by Anjin on 11/20/24.
//

import Foundation

struct PriceResponseDTO: Decodable {
  let accommodation: PriceAccommodationDTO
  let cafe: PriceCafeDTO
  let restaurant: PriceRestaurantDTO
}

struct PriceAccommodationDTO: Decodable {
  let threeStar: Double
  let fourStar: Double
  let guestHouse: Double
  
  // JSON 키와 프로퍼티 이름 매핑
  enum CodingKeys: String, CodingKey {
    case threeStar = "3star"
    case fourStar = "4star"
    case guestHouse = "guestHouse"
  }
}

struct PriceCafeDTO: Decodable {
  let local: Double
  let starbucks: Double
}

struct PriceRestaurantDTO: Decodable {
  let local: Double
  let casualDining: Double
}
