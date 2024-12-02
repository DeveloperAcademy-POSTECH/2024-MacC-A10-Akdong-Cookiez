//
//  RecordRepository.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

protocol RecordRepository {
  /// 사용자가 사용중이던 기본 국가명(최초 실행 시 첫번째 국가명)을 반환하는 메서드
  func fetchSelectedCountry() -> Result<String?, Error>
  /// 사용자가 설정한 국가명을 저장하는 메서드
  func saveSelectedCountry(_ country: String) -> Result<VoidResponse, Error>
  /// 직전 소비 기록을 반환하는 메서드
  func fetchPreviousDaySpending(country: String, category: String) -> Result<UserRecord?, Error>
  /// 특정 나라의 모든 소비 기록을 반환하는 메서드
  func fetchAllUserRecord(at country: String?) -> Result<[UserRecord?], Error>
  /// 소비 기록을 저장하는 메서드
  func saveRecord(record: UserRecord) -> Result<VoidResponse, Error>
}
