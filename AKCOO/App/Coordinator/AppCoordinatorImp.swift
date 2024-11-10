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
    let useCase = TravelUseCase()
    let coordinator = TravelCoordinatorImp(self.navigationController)
    childCoordinators.append(coordinator)
    navigationController.viewControllers = [TravelListSceneFactoryImp().create(coordinator: coordinator, useCase: useCase)]
  }
}
