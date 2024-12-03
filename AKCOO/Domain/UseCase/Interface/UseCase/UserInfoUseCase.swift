//
//  UserInfoUseCase.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import Foundation

protocol UserInfoUseCase {
  /// 사용자의 판단 유형을 가져오는 메서드
  func getUserJudgmentTypeModel() -> Result<UserJudgmentTypeModel, Error>
}
