//
//  UserInfoUseCase.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import Foundation

protocol UserInfoUseCase {
  /// 나의 모든 지출 판단 기록을 가져오는 메서드
  func getUserRecords() -> Result<[UserRecord], Error>
}
