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
      UserRecord(
        userQuestion: UserQuestion(
          country: CountryProfile(
            name: "베트남",
            currency: Currency(
              unitTitle: "동",
              unit: 0.055
            )
          ),
          category: "카테고리1",
          amount: 200_000
        ),
        userJudgment: .buying,
        externalJudgment: [
          "베트남 10년차": .buying,
          "한국 토박이": .notBuying,
          "과거의 나": .buying
        ]
      ),
      UserRecord(
        userQuestion: UserQuestion(
          country: CountryProfile(
            name: "베트남",
            currency: Currency(
              unitTitle: "동",
              unit: 0.055
            )
          ),
          category: "카테고리2",
          amount: 100_000
        ),
        userJudgment: .notBuying,
        externalJudgment: [
          "베트남 10년차": .buying,
          "한국 토박이": .notBuying,
          "과거의 나": .buying
        ]
      ),
      UserRecord(
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
    ])
  }
}

#Preview {
  UserInfoViewController(userInfoUseCase: UserInfoUseCaseMock())
}
