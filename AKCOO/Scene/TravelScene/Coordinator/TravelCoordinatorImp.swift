//
//  TravelListCoordinatorImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class TravelCoordinatorImp: TravelCoordinator {
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: UINavigationController
  
  var childCoordinators = [Coordinator]()
  var type: CoordinatorType { .travelList }
  
  private let travelNewCoordinator: any TravelNewCoordinator
  private let travelListSceneFactory: any TravelListSceneFactory
  private let expenseSceneFactory: any ExpenseSceneFactory
  private let expenseRecordFactory: any ExpenseRecordFactory
  private let expenseStatsFactory: any ExpenseStatsFactory
  
  required init(
    _ navigationController: UINavigationController,
    travelNewCoordinator: any TravelNewCoordinator,
    travelListSceneFactory: any TravelListSceneFactory,
    expenseSceneFactory: any ExpenseSceneFactory,
    expenseRecordFactory: any ExpenseRecordFactory,
    expenseStatsFactory: any ExpenseStatsFactory
  ) {
    self.navigationController = navigationController
    self.travelNewCoordinator = travelNewCoordinator
    self.travelListSceneFactory = travelListSceneFactory
    self.expenseSceneFactory = expenseSceneFactory
    self.expenseRecordFactory = expenseRecordFactory
    self.expenseStatsFactory = expenseStatsFactory
  }
  
  func start() {
    let viewController = travelListSceneFactory.create(coordinator: self)
    self.navigationController.viewControllers = [viewController]
    if true { // 등록된 여행이 있다면
      let id = "실제로는UseCase에서불러오기"
      let cellIndexPath: IndexPath? = .none // 저장해두거나 직접 불러와서 계산할 타이밍 고려
      self.presentExpense(travelId: id, cellIndexPath: cellIndexPath, form: viewController)
    }
  }
  
  func presentExpense(
    travelId id: String,
    cellIndexPath: IndexPath?, // transition에 주입해 주기
    form presenting: UIViewController
  ) {
    let recordViewController = expenseRecordFactory.create(travelId: id, coordinator: self)
    let statsViewController = expenseStatsFactory.create(travelId: id, coordinator: self)
    let expenseSenceController = expenseSceneFactory.create(travelId: id, recordViewController: recordViewController, statsViewController: statsViewController)
    
    expenseSenceController.modalPresentationStyle = .custom
    
    // TODO: - Transition 로직
    // customTransitionDelegate.indexPath
    // expenseSenceController.transitioningDelegate = self.customTransitionDelegate
    
    presenting.present(expenseSenceController, animated: true)
  }
  
  func tappedPlusButton() {
    travelNewCoordinator.finishDelegate = self
    travelNewCoordinator.parents = self
    travelNewCoordinator.start()
    self.childCoordinators.append(travelNewCoordinator)
  }
  
  func tappedListButton() {
    navigationController.dismiss(animated: true, completion: nil)
  }
}

extension TravelCoordinatorImp: TravelNewCoordinatorDelegate {
  func newTravel(_ new: Travel) {
    if let viewController = navigationController.viewControllers.first as? TravelListSceneController {
      viewController.configureNewTravel(new)
    }
  }
}

extension TravelCoordinatorImp: CoordinatorFinishDelegate {
  func coordinatorDidFinish(childCoordinator: any Coordinator) {
    self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
  }
}
