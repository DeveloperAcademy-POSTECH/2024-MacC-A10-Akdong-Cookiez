//
//  TravelNewCoordinatorImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class TravelNewCoordinatorImp: NSObject, TravelNewCoordinator, UINavigationControllerDelegate {
  weak var finishDelegate: CoordinatorFinishDelegate?
  var navigationController: UINavigationController
  
  var childCoordinators = [Coordinator]()
  var type: CoordinatorType { .travelNew }
  
  required init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    navigationController.delegate = self // swipe 제스쳐 인지
    let newViewController = TravelNewSceneController(useCase: TravelUseCase())
    newViewController.coordinator = self
    newViewController.view.backgroundColor = .white
    self.navigationController.pushViewController(newViewController, animated: true)
  }
  
  func tappedSaveButton(new travel: Travel) {
    guard let travelListViewController = navigationController.viewControllers.first(where: { $0 is TravelListSceneController }) as? TravelListSceneController else { return }
    // TravelListSceneController 타입의 인스턴스를 찾음
    // 값을 조정하거나 원하는 작업 수행
    travelListViewController.submitNewTravel(travel)
    finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
  
  // UINavigationControllerDelegate 메서드
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    // 스택의 변경사항을 확인하여 뷰 컨트롤러가 pop되었는지 감지
    guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
    !navigationController.viewControllers.contains(fromViewController) else { return }
    
    guard fromViewController is TravelNewSceneController else { return }
    // Controller 타입 감추고 정확한 CoordinatorType에 따른 분기 필요
    self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
}
