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

//extension AppCoordinatorImp: CoordinatorFinishDelegate {
//  func coordinatorDidFinish(childCoordinator: Coordinator) {
//    self.childCoordinators = self.childCoordinators.filter({ $0.type != childCoordinator.type })
//    
//    self.navigationController.viewControllers.removeAll()
//    
//    switch childCoordinator.type {
//    case .travelList:
//      self.showExpenseFlow()
//    case .expense:
//      self.showTravelListFlow()
//    default:
//      break
//    }
//  }
//}

//class CustomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
//  var indexPath: IndexPath?
//  
//  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    return CustomPresentAnimationController(indexPath: indexPath)
//  }
//  
//  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    return CustomDismissAnimationController()
//  }
//}
//
//class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
//  
//  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//    return 0.5 // 전환 애니메이션 시간
//  }
//  
//  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//    guard let fromViewController = transitionContext.viewController(forKey: .from) as? TravelListSceneController,
//          let toViewController = transitionContext.viewController(forKey: .to) as? ExpenseSceneController else { return },
//    let destinationViewController = toViewController.viewController
//    guard let cellIndexPath = fromViewController.getSelectedCellIndexPath(),
//          let cell = fromViewController.travelTableView.cellForRow(
//      at: cellIndexPath),
//          let selectedCell = cell as? TravelTableViewCell else { return }
//    
//    let containerView = transitionContext.containerView
//    toViewController.alpha = 0
//    containerView.addSubview(toViewController)
//    
//    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//      toViewController.alpha = 1
//    }) { finished in
//      print("??!")
//      transitionContext.completeTransition(finished)
//    }
//  }
//}
//
//class CustomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
//  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//    return 0.5
//  }
//  
//  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//    guard let fromView = transitionContext.view(forKey: .from) else { return }
//    
//    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//      fromView.alpha = 0
//    }) { finished in
//      print("??")
//      transitionContext.completeTransition(finished)
//      fromView.removeFromSuperview()
//    }
//  }
//}
