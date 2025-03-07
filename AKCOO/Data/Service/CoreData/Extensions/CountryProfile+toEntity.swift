//
//  CountryProfile+toEntity.swift
//  AKCOO
//
//  Created by Anjin on 11/24/24.
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
}
