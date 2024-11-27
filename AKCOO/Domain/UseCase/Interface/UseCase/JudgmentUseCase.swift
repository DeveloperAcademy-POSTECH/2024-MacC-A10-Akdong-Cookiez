//
//  JudgmentUseCase.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

protocol JudgmentUseCase {
  /// 판단을 저장하는 메서드
  func save(record: UserRecord) -> Result<VoidResponse, Error>
  /// 화면에 필요한 정보를 반환하는 메서드
  func getPaperModel() -> Result<PaperModel, Error>
  /// 직전 소비가 존재하는 지 확인하는 메서드
  func isPreviousRecordExists(for country: String, category: String) -> Bool
  /// 나라 변경 후 필요한 정보를 반환하는 메서드
  func getNewPaperModel(newCountryName selectedCountryName: String) -> Result<PaperModel, Error>
  /// 특정 국가, 카테고리, 서브 카테고리에 대한 판정을 요청하는 메서드
  func getBirdsJudgment(userQuestion: UserQuestion) -> Result<[BirdModel], Error>
}
