//
//  UserInfoFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

struct UserInfoFactoryImp: UserInfoFactory {
  let useCase: UserInfoUseCase
  
  func create(coordinator: UserInfoCoordinator) -> UIViewController {
    let userInfoController = UserInfoViewController(userInfoUseCase: useCase)
    userInfoController.coordinator = coordinator
    return userInfoController
  }
}
