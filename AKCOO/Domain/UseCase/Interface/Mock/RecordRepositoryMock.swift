//
//  RecordRepositoryMock.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

struct RecordRepositoryMock: RecordRepository {
  func fetchSelectedCountry() -> Result<String?, any Error> {
    return .success("베트남")
  }
  
  func saveSelectedCountry(_ country: String) -> Result<VoidResponse, any Error> {
    return .success(.init())
  }

  func fetchPreviousDaySpending(country: String, category: String) -> Result<UserRecord?, any Error> {
    .success(nil)
  }
  
  func fetchAllUserRecord(at country: String?) -> Result<[UserRecord?], any Error> {
    return .success([])
  }
  
  func saveRecord(record: UserRecord) -> Result<VoidResponse, Error> {
    return .success(VoidResponse())
  }
}
