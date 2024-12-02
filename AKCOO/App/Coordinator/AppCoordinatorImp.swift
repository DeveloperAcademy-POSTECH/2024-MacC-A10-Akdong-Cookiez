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
    self.navigationController.view.backgroundColor = .akColor(.akBlue400)
  }
  
  // App 폴더 내 최상위 Coordinator인 AppCoordinator이므로 직접 주입합니다
  func start() {
    let judgmentRepository = JudgmentRepositoryMock()
    let recordRepository = RecordRepositoryImp()
    
    let judgmentUseCase = JudgmentUseCaseImp(
      judgmentRepository: judgmentRepository,
      recordRepository: recordRepository
    )
    
    let guideUseCase = GuideUseCaseImp(
      judgmentRepository: judgmentRepository,
      recordRepository: recordRepository
    )
    
    let userInfoUseCase = UserInfoUseCaseImp()
    let guideFactory = GuideFactoryImp(useCase: guideUseCase)
    let userInfoFactory = UserInfoFactoryImp(useCase: userInfoUseCase)
    
    let judgmentReadyFactory = JudgmentReadyFactoryImp(useCase: judgmentUseCase)
    let judgmentCompletedFactory = JudgmentCompletedFactoryImp(useCase: judgmentUseCase)
    let judgmentEditFactory = JudgmentEditFactoryImp(useCase: judgmentUseCase)
    
    let judgmentCoordinator = JudgmentCoordinatorImp(
      navigationController,
      judgmentReadyNewfactory: judgmentReadyFactory,
      judgmentCompletedFactory: judgmentCompletedFactory, 
      judgmentEditFactory: judgmentEditFactory
    )
    
    let guideCoordinator = GuideCoordinatorImp(
      navigationController,
      judgmentCoordinator: judgmentCoordinator,
      guideFactory: guideFactory,
      userInfoFactory: userInfoFactory
    )
    
    childCoordinators.append(guideCoordinator)
    guideCoordinator.start()
  }
}
