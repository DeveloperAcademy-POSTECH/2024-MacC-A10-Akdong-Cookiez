//
//  UserInfoUseCaseImp.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import Foundation

struct UserInfoUseCaseImp: UserInfoUseCase {
  func getUserRecords() -> Result<[UserRecord], any Error> {
    return .success([])
  }
}
