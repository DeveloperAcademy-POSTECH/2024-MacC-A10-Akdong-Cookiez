//
//  AppCoordinatorImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

final class AppCoordinatorImp: AppCoordinator {
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  var type: CoordinatorType { .app }
  
  required init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.navigationController.view.backgroundColor = .white
  }
  
  func start() {
    if true { // 등록된 화면이 있다면
      self.showTravelListFlow()
      self.showExpenseFlow()
    } else {
      self.showTravelListFlow()
    }
  }
  
  func showExpenseFlow() {
    let expenseCoordinator = ExpenseCoordinatorImp(countryID: 0, self.navigationController)
    expenseCoordinator.finishDelegate = self
    expenseCoordinator.start()
    childCoordinators.append(expenseCoordinator)
  }
  
  func showTravelListFlow() {
    let tarvelListCoordinator = TravelListCoordinatorImp(self.navigationController)
    tarvelListCoordinator.finishDelegate = self
    tarvelListCoordinator.start()
    childCoordinators.append(tarvelListCoordinator)
  }
}

extension AppCoordinatorImp {
  func tappedCountry(id: Int) {
    
  }
}

extension AppCoordinatorImp: CoordinatorFinishDelegate {
  func coordinatorDidFinish(childCoordinator: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
    
    self.navigationController.viewControllers.removeAll()
    
    switch childCoordinator.type {
    case .travelList:
      self.showExpenseFlow()
    case .expense:
      self.showTravelListFlow()
    default:
      break
    }
  }
}
