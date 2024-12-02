//
//  GuideCoordinatorImp.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

class GuideCoordinatorImp: GuideCoordinator, UserInfoCoordinator {
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  var type: CoordinatorType { .guide }
  
  private let judgmentCoordinator: any JudgmentCoordinator
  private let guideFactory: any GuideFactory
  private let userInfoFactory: any UserInfoFactory
  
  required init(
    _ navigationController: UINavigationController,
    judgmentCoordinator: any JudgmentCoordinator,
    guideFactory: any GuideFactory,
    userInfoFactory: any UserInfoFactory
  ) {
    self.navigationController = navigationController
    self.judgmentCoordinator = judgmentCoordinator
    self.guideFactory = guideFactory
    self.userInfoFactory = userInfoFactory
  }
  
  func start() {
    let guideViewController = guideFactory.create(coordinator: self)
    guideViewController.navigationItem.backButtonTitle = ""
    navigationController.navigationBar.tintColor = .black
    navigationController.view.backgroundColor = .akColor(.akGray100)
    self.navigationController.viewControllers = [guideViewController]
  }
  
  func startJudgmentReady(presenting: UIViewController, selectedCountryDetail: CountryDetail) {
    judgmentCoordinator.finishDelegate = self
    judgmentCoordinator.selectedCountryDetail = selectedCountryDetail
    childCoordinators.append(judgmentCoordinator)
    judgmentCoordinator.start()
  }
  
  func startUserInfo() {
    let userViewController = userInfoFactory.create(coordinator: self)
    userViewController.view.backgroundColor = .akColor(.akGray100)
    self.navigationController.pushViewController(userViewController, animated: true)
  }
  
  func completedUserInfo() {
    self.navigationController.popViewController(animated: true)
  }
}

// MARK: - CoordinatorFinishDelegate
extension GuideCoordinatorImp: CoordinatorFinishDelegate {
  func coordinatorDidFinish(childCoordinator: any Coordinator) {
    self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
  }
}
