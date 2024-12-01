//
//  UserInfoUseCaseMock.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import Foundation

struct UserInfoUseCaseMock: UserInfoUseCase {
  func getUserRecords() -> Result<[UserRecord], any Error> {
    return .success([])
  }
}
