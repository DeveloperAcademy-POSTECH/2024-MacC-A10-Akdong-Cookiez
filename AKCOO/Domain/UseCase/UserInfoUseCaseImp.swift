//
//  UserInfoUseCaseImp.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import Foundation

struct UserInfoUseCaseImp: UserInfoUseCase {
  
  private let recordRepository: RecordRepository
  
  init(recordRepository: RecordRepository) {
    self.recordRepository = recordRepository
  }
  
  /// 사용자의 판단 유형 조회
  func getUserJudgmentTypeModel() -> Result<UserJudgmentTypeModel, any Error> {
    do {
      let selectedCountry = try recordRepository.fetchSelectedCountry().get()
      let userRecords = try recordRepository.fetchAllUserRecord(at: selectedCountry)
        .get()
        .compactMap { $0 }
      
      return .success(UserJudgmentTypeModel(userRecords: userRecords))
    } catch {
      return .failure(error)
    }
  }
}
