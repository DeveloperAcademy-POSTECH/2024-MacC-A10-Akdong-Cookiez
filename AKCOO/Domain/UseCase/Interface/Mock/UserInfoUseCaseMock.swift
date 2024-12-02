//
//  UserInfoUseCaseMock.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import UIKit

struct UserInfoUseCaseMock: UserInfoUseCase {
  func getUserRecords() -> Result<[UserRecord], any Error> {
    return .success([
      UserRecord.dummy(),
      UserRecord.dummy(),
      UserRecord.dummy(),
      UserRecord.dummy(),
      UserRecord.dummy(),
      UserRecord.dummy(),
      UserRecord.dummy()
    ])
  }
}

#Preview {
  UserInfoViewController(userInfoUseCase: UserInfoUseCaseMock())
}

extension UserRecord {
  static func dummy() -> UserRecord {
    return UserRecord(
      userQuestion: UserQuestion(
        country: CountryProfile(
          name: "베트남",
          currency: Currency(
            unitTitle: "동",
            unit: 0.055
          )
        ),
        category: "카테고리3",
        amount: 300_000
      ),
      userJudgment: .buying,
      externalJudgment: [
        "베트남 10년차": .buying,
        "한국 토박이": .notBuying,
        "과거의 나": .buying
      ]
    )
  }
}
