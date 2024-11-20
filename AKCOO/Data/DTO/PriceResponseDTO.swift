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
  
  enum CodingKeys: String, CodingKey {
    case threeStar = "3Star"
    case fourStar = "4Star"
    case guestHouse = "guesthouse"
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
