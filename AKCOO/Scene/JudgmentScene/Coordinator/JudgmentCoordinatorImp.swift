//
//  JudgmentCoordinatorImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class JudgmentCoordinatorImp: JudgmentCoordinator {
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  var type: CoordinatorType { .judement }
  
  private let judgmentReadyFactory: any JudgmentReadyFactory
  private let judgmentCompletedFactory: any JudgmentCompletedFactory
  private let judgmentEditFactory: any JudgmentEditFactory
  
  private let startTransitionaler = StartTransitionaler()
  private let editTransitionaler = EditTransitionaler()
  
  required init(
    _ navigationController: UINavigationController,
    judgmentReadyNewfactory: any JudgmentReadyFactory,
    judgmentCompletedFactory: any JudgmentCompletedFactory,
    judgmentEditFactory: any JudgmentEditFactory
  ) {
    self.navigationController = navigationController
    self.judgmentReadyFactory = judgmentReadyNewfactory
    self.judgmentCompletedFactory = judgmentCompletedFactory
    self.judgmentEditFactory = judgmentEditFactory
  }
  
  func start() {
    let newViewController = judgmentReadyFactory.create(coordinator: self)
    self.navigationController.viewControllers = [newViewController]
  }
  
  func startJudgment(presenting: UIViewController, userQuestion: UserQuestion) { // 데이터 받아와서 진행
    let judgmentCompletedViewController = judgmentCompletedFactory.create(coordinator: self, userQuestion: userQuestion)
    judgmentCompletedViewController.modalPresentationStyle = .custom
    judgmentCompletedViewController.transitioningDelegate = self.startTransitionaler
    presenting.present(judgmentCompletedViewController, animated: true)
  }
  
  func startEditPaper(presenting: UIViewController) { // 데이터 받아와서 진행
    // TODO: - judgmentEditFactory로 변경 후 Transition 연결 
    let readyViewController = judgmentReadyFactory.create(coordinator: self)
    readyViewController.modalPresentationStyle = .custom
    readyViewController.transitioningDelegate = self.editTransitionaler
    presenting.present(readyViewController, animated: true)
  }
  
  func completedEditPaper(editViewController: JudgmentEditViewController) { // 데이터 받아와서 진행
    editViewController.dismiss(animated: true)
//    editViewController.presentingViewController?.dismiss(animated: true)
  }
}
