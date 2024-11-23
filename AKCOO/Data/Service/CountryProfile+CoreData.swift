//
//  CountryProfile+CoreData.swift
//  AKCOO
//
//  Created by Anjin on 11/22/24.
//

import CoreData

extension CountryProfile {
  static func toEntity(context: NSManagedObjectContext, profile: CountryProfile) -> CountryProfileEntity {
    let entity = CountryProfileEntity(context: context)
    entity.name = profile.name
    entity.currencyUnitTitle = profile.currency.unitTitle
    entity.currencyExchangeRate = profile.currency.unit
    return entity
  }
  
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
