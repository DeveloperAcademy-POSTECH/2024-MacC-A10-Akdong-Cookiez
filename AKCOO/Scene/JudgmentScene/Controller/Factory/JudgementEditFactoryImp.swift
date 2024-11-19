//
//  JudgmentEditFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import Foundation

import UIKit

struct JudgmentEditFactoryImp: JudgmentEditFactory {
  let useCase: JudgmentUseCase
  
  func create(coordinator: JudgmentCoordinator) -> UIViewController {
    let readyController = JudgmentEditViewController(judgmentUseCase: useCase)
    readyController.coordinator = coordinator
    return readyController
  }
  
  func dismiss(editViewController viewController: UIViewController) {
    viewController.presentingViewController?.dismiss(animated: true)
  }
}
