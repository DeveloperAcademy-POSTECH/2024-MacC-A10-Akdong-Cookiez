//
//  RecordRepositoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/16/24.
//

import Foundation

// MARK: - 이오가 만들어줄 거야
struct RecordRepositoryImp: RecordRepository {
  func saveSelectedCountry(_ country: String) -> Result<VoidResponse, any Error> {
    return .success(.init())
  }
  
  func fetchSelectedCountry() -> Result<String?, any Error> {
    return .success("베트남")
  }
  
  func fetchPreviousDaySpending(country: String, category: String) -> Result<UserRecord?, any Error> {
    .success(nil)
  }
  
  func saveRecord(record: UserRecord) -> Result<VoidResponse, Error> {
    // 사용자 기록을 저장합니다
    print("Mock Record saved: \(record)")
    return .success(VoidResponse())
  }
}
