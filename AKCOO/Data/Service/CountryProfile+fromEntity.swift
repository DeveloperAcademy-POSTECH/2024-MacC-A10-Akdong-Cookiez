//
//  CountryProfile+fromEntity.swift
//  AKCOO
//
//  Created by Anjin on 11/24/24.
//

import CoreData

extension CountryProfile {
  static func fromEntity(entity: CountryProfileEntity) -> Result<CountryProfile?, Error> {
    guard
      let name = entity.name,
      let unitTitle = entity.currencyUnitTitle
    else {
      return .success(nil)
    }
    
    let countryProfile = CountryProfile(
      name: name,
      currency: Currency(
        unitTitle: unitTitle,
        unit: entity.currencyExchangeRate
      )
    )
    
    return .success(countryProfile)
  }
}
