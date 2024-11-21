//
//  UserDefaultsService.swift
//  AKCOO
//
//  Created by Anjin on 11/21/24.
//

import Foundation

struct UserDefaultsService {
  // 저장
  func save<T>(value: T, key: UserDefaultsConstants.Keys) {
    UserDefaults.standard.set(value, forKey: key.rawValue)
  }
  
  // 불러오기
  func load<T>(type: T.Type, key: UserDefaultsConstants.Keys) -> T? {
    let data = UserDefaults.standard.value(forKey: key.rawValue) as? T
    return data
  }
  
  // 삭제
  func remove(key: UserDefaultsConstants.Keys) {
    UserDefaults.standard.removeObject(forKey: key.rawValue)
  }
}
