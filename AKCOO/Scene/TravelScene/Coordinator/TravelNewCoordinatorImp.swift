//
//  TravelNewCoordinatorImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class TravelNewCoordinatorImp: NSObject, TravelNewCoordinator {
  weak var parents: TravelNewCoordinatorDelegate?
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: UINavigationController
  
  var childCoordinators = [Coordinator]()
  var type: CoordinatorType { .travelNew }
  
  private let travelNewfactory: any TravelNewSceneFactory
  
  required init(_ navigationController: UINavigationController, factory: any TravelNewSceneFactory) {
    self.navigationController = navigationController
    self.travelNewfactory = factory
  }
  
  func start() {
    let newViewController = travelNewfactory.create(coordinator: self)
    self.navigationController.delegate = self // 스와이프 제스쳐 연결
    self.navigationController.pushViewController(newViewController, animated: true)
  }
  
  func tappedSaveButton(new travel: Travel) {
    self.parents?.newTravel(travel)
    navigationController.popToRootViewController(animated: true)
  }
}

extension TravelNewCoordinatorImp: UINavigationControllerDelegate {
  // 제스쳐로 뒤로가기 이동 경우를 고려
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    if navigationController.viewControllers.count == 1 {
      self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
  }
}
