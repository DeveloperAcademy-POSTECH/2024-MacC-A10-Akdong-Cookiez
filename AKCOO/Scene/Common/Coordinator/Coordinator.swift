//
//  Coordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

protocol Coordinator: AnyObject {
  var finishDelegate: CoordinatorFinishDelegate? { get set }
  var navigationController: UINavigationController { get set }
  var childCoordinators: [Coordinator] { get set }
  var type: CoordinatorType { get }
  
  func start()
  func finish()
}

extension Coordinator {
  func finish() {
    childCoordinators.removeAll()
    finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
}
