//
//  ExpenseCoordinatorImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class ExpenseCoordinatorImp: ExpenseCoordinator {
  weak var finishDelegate: CoordinatorFinishDelegate?
  
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  var type: CoordinatorType { .expense }
  
  private let id: Int
  
  required init(countryId: Int, _ navigationController: UINavigationController) {
    self.id = countryId
    self.navigationController = navigationController
  }
  
  public func start() {
    let useCase = ExpenseUseCase()
    let recordViewController = ExpenseRecordViewController(countryId: self.id, expenseUseCase: useCase)
    let statsViewController = ExpenseStatsViewController(countryId: self.id, expenseUseCase: useCase)
    recordViewController.coordinator = self
    statsViewController.coordinator = self
    
    let expenseSenceController = ExpenseSceneController(recordViewController: recordViewController, statsViewController: statsViewController)
    expenseSenceController.modalPresentationStyle = .fullScreen
    expenseSenceController.view.backgroundColor = .white
    
    navigationController.present(expenseSenceController, animated: false)
  }
  
  public func tappedListButton() {
    navigationController.dismiss(animated: true, completion: nil)
    self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
  }
}
