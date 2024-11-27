//
//  JudgmentCompletedFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

struct JudgmentCompletedFactoryImp: JudgmentCompletedFactory {
  let useCase: JudgmentUseCase
  
  func create(coordinator: JudgmentCoordinator, delegate: any JudgmentCompletedViewControllerDelegate,userQuestion: UserQuestion) -> UIViewController {
    let judgmentCompletedViewController = JudgmentCompletedViewController(judgmentUseCase: useCase, userQuestion: userQuestion)
    judgmentCompletedViewController.coordinator = coordinator
    judgmentCompletedViewController.delegate = delegate
    return judgmentCompletedViewController
  }
  
  func dismisser(judgmentCompletedViewController viewController: UIViewController) {
    viewController.presentingViewController?.dismiss(animated: true)
  }
}
