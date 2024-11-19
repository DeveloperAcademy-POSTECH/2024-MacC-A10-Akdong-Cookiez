//
//  JudgmentReadyFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

struct JudgmentReadyFactoryImp: JudgmentReadyFactory {
  let useCase: JudgmentUseCase
  
  func create(coordinator: JudgmentCoordinator) -> UIViewController {
    let readyController = JudgmentReadyViewController(judgmentUseCase: useCase)
    readyController.coordinator = coordinator
    return readyController
  }
}
