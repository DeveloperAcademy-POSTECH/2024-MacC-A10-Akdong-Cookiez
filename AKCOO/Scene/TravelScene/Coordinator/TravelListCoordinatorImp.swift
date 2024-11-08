//
//  TravelListCoordinatorImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class TravelListCoordinatorImp: TravelListCoordinator {
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: UINavigationController
  
  var childCoordinators = [Coordinator]()
  var type: CoordinatorType { .travelList }
  
  required init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let taravelViewController = TravelListSceneController(useCase: TravelUseCase())
    taravelViewController.coordinator = self
    self.navigationController.viewControllers = [taravelViewController]
  }
  
  func tappedPlusButton() {
    let newCoordinator = TravelNewCoordinatorImp(self.navigationController)
    newCoordinator.finishDelegate = self
    newCoordinator.start()
    self.childCoordinators.append(newCoordinator)
  }
  
  func tappedCell(id countryId: String) {
    finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
}

extension TravelListCoordinatorImp: CoordinatorFinishDelegate {
  func coordinatorDidFinish(childCoordinator: any Coordinator) {
    self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
    switch childCoordinator.type {
    case .travelNew:
      self.navigationController.popViewController(animated: true)
    default:
      break
    }
  }
}
