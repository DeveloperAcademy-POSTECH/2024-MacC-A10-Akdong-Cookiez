//
//  JudgmentCompletedFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

struct JudgmentCompletedFactoryImp: JudgmentCompletedFactory {
  let useCase: JudgmentUseCase
  
  func create(coordinator: JudgmentCoordinator) -> UIViewController {
    let judgmentCompletedViewController = JudgmentCompletedViewController(judgmentUseCase: useCase)
    judgmentCompletedViewController.coordinator = coordinator
    return judgmentCompletedViewController
  }
  
  func dismisser(judgmentCompletedViewController viewController: UIViewController) {
    viewController.presentingViewController?.dismiss(animated: true)
  }
}
