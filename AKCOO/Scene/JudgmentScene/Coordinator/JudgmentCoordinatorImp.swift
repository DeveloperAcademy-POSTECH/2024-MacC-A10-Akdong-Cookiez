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
  
  private let judgmentTransitionaler = JudgmentTransitionaler()
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
  
  func startJudgment(presenting: JudgmentCompletedViewControllerDelegate, userQuestion: UserQuestion) { // 데이터 받아와서 진행
    let judgmentCompletedViewController = judgmentCompletedFactory.create(coordinator: self, delegate: presenting, userQuestion: userQuestion)
    judgmentCompletedViewController.modalPresentationStyle = .overFullScreen
    judgmentCompletedViewController.transitioningDelegate = self.judgmentTransitionaler
    judgmentCompletedViewController.view.backgroundColor = .akColor(.akBlue400)
    presenting.present(judgmentCompletedViewController, animated: true)
  }
  
  func completedJudgment(judgmentViewController: UIViewController) {
    judgmentViewController.presentingViewController?.dismiss(animated: true)
  }
  
  func startEditPaper(presenting: JudgmentEditViewControllerDelegate, paperModel: PaperModel, selectedCategory: String, userAmount: String) { // 데이터 받아와서 진행
    // TODO: - judgmentEditFactory로 변경 후 Transition 연결
    let editViewController = judgmentEditFactory.create(coordinator: self, paperModel: paperModel, selectedCategory: selectedCategory, userAmount: userAmount, delegate: presenting)
    editViewController.modalPresentationStyle = .overFullScreen
    editViewController.transitioningDelegate = self.editTransitionaler
    presenting.present(editViewController, animated: true)
  }
  
  func completedEditPaper(editViewController: UIViewController) {  // 데이터 받아와서 진행
//    editViewController.dismiss(animated: true)
    editViewController.presentingViewController?.dismiss(animated: true)
  }
}
