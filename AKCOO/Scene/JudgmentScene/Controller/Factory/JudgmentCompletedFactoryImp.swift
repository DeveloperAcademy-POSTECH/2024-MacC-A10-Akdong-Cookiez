//
//  JudgmentCompletedFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

struct JudgmentCompletedFactoryImp: JudgmentCompletedFactory {
  let useCase: JudgmentUseCase
  
  func create(coordinator: JudgmentCoordinator, userQuestion: UserQuestion) -> UIViewController {
    let judgmentCompletedViewController = JudgmentCompletedViewController(judgmentUseCase: useCase, userQuestion: userQuestion)
    judgmentCompletedViewController.coordinator = coordinator
    return judgmentCompletedViewController
  }
  
  func dismisser(judgmentCompletedViewController viewController: UIViewController) {
    viewController.presentingViewController?.dismiss(animated: true)
  }
}
