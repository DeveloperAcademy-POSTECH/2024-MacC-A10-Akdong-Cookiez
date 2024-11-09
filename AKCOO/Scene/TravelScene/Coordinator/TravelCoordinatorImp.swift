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
  
  required init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = TravelListSceneFactoryImp().create(coordinator: self, useCase: TravelUseCase())
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
    let useCase = ExpenseUseCase()
    let recordViewController = ExpenseRecordFactoryImp().create(travelId: id, coordinator: self, useCase: useCase)
    let statsViewController = ExpenseStatsFactoryImp().create(travelId: id, coordinator: self, useCase: useCase)
    let expenseSenceController = ExpenseSceneFactoryImp().create(travelId: id, coordinator: self, useCase: useCase, recordViewController: recordViewController, statsViewController: statsViewController)
    
    expenseSenceController.modalPresentationStyle = .custom
    
    //    customTransitionDelegate.indexPath
    //    expenseSenceController.transitioningDelegate = self.customTransitionDelegate
    
    presenting.present(expenseSenceController, animated: true)
  }
  
  func tappedPlusButton() {
    let newCoordinator = TravelNewCoordinatorImp(self.navigationController)
    newCoordinator.finishDelegate = self
    newCoordinator.parents = self
    newCoordinator.start()
    self.childCoordinators.append(newCoordinator)
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
