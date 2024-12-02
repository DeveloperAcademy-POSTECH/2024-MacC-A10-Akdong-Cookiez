//
//  UserJudgmentType.swift
//  AKCOO
//
//  Created by Anjin on 12/3/24.
//

import Foundation

enum UserJudgmentType {
  case foreign(CountryProfile)
  case local(CountryProfile)
  case previous
  case empty
}
