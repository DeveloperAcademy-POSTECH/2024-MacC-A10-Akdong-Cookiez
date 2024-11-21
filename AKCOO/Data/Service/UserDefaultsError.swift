//
//  UserDefaultsError.swift
//  AKCOO
//
//  Created by Anjin on 11/21/24.
//

import Foundation

enum UserDefaultsError: LocalizedError {
  case keyNotFound(key: String)
  
  var errorDescription: String? {
    switch self {
    case .keyNotFound(let key):
      return "UserDefaults에 찾으려는 key \(key)가 없습니다"
    }
  }
}
