//
//  CountryDetail.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

struct CountryDetail {
  private var country: CountryProfile
  var items: [Item]
  
  init(country: CountryProfile, items: [Item]) {
    self.country = country
    self.items = items
  }
  
  var name: String { return country.name }
  var categories: [String] {
    return Set(items.map { $0.category }).sorted().map { $0 }
  }
  var currency: Currency { return country.currency }
}
