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
  
  // App 폴더 내 최상위 Coordinator인 AppCoordinator이므로 직접 주입합니다
  func start() {
    let travelUseCase = TravelUseCaseImp()
    let expenseUseCase = ExpenseUseCaseImp()
    let travelListSceneFactory = TravelListSceneFactoryImp(useCase: travelUseCase)
    let travelNewFactory = TravelNewSceneFactoryImp(useCase: travelUseCase)
    let expenseSceneFactory = ExpenseSceneFactoryImp()
    let expenseRecordFactory = ExpenseRecordFactoryImp(useCase: expenseUseCase)
    let expenseStatsFactory = ExpenseStatsFactoryImp(useCase: expenseUseCase)
    
    let travelNewCoordinator = TravelNewCoordinatorImp(
      self.navigationController,
      factory: travelNewFactory
    )
    
    let travelCoordinator = TravelCoordinatorImp(
      self.navigationController,
      travelNewCoordinator: travelNewCoordinator, 
      travelListSceneFactory: travelListSceneFactory,
      expenseSceneFactory: expenseSceneFactory,
      expenseRecordFactory: expenseRecordFactory,
      expenseStatsFactory: expenseStatsFactory
    )
    
    childCoordinators.append(travelCoordinator)
    travelCoordinator.start()
  }
}
