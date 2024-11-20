//
//  PriceResponseDTO.swift
//  AKCOO
//
//  Created by Anjin on 11/20/24.
//

import Foundation

struct PriceResponseDTO: Decodable {
  let category: String
  let item: String
  let price: Double
}
