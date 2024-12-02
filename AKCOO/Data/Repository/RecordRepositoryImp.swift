//
//  RecordRepositoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/16/24.
//

import Foundation

// MARK: - 이오가 만들어줄 거야
struct RecordRepositoryImp: RecordRepository {
  private let userDefaults = UserDefaultsService()
  private let coreData = CoreDataService()
  
  /// 사용자가 선택한 나라를 저장
  func saveSelectedCountry(_ country: String) -> Result<VoidResponse, any Error> {
    userDefaults.save(value: country, key: .selectedCountry)
    return .success(.init())
  }
  
  /// 사용자가 선택한 나라를 불러오기
  func fetchSelectedCountry() -> Result<String?, any Error> {
    switch userDefaults.load(type: String.self, key: .selectedCountry) {
    case .success(let country):
      return .success(country)
    case .failure:
      // FIXME: return 타입 논의 후 수정
      // return Type이 String?으로 Optional 형태라
      // Key를 찾지 못해 반환되는 error를 보내야 할지
      // nil로 return 해야 할지 고민중!
      return .success(nil)
    }
  }
  
  /// 사용자의 직전 소비 기록을 반환
  func fetchPreviousDaySpending(country: String, category: String) -> Result<UserRecord?, any Error> {
    switch coreData.getLatestUserRecord(country: country, category: category) {
    case .success(let success):
      return .success(success)
    case .failure(let error):
      return .failure(error)
    }
  }
  
  /// 특정 나라의 모든 소비 기록을 반환
  func fetchAllUserRecord(at country: String?) -> Result<[UserRecord?], any Error> {
    switch coreData.getUserRecord(at: country) {
    case .success(let success):
      return .success(success)
    case .failure(let error):
      return .failure(error)
    }
  }
  
  /// 사용자가 선택한 소비 기록을 저장
  func saveRecord(record: UserRecord) -> Result<VoidResponse, Error> {
    switch coreData.saveUserRecord(record) {
    case .success(let response):
      return .success(response)
    case .failure(let error):
      return .failure(error)
    }
  }
}
