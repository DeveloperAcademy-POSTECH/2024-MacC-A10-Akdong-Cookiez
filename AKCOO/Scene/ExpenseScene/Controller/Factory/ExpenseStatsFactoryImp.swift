//
//  ExpenseStatsFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

struct ExpenseStatsFactoryImp: ExpenseStatsFactory {
  func create(travelId id: String, coordinator: TravelCoordinator, useCase: ExpenseUseCase) -> UIViewController {
    
    let viewController = ExpenseStatsViewController(travelId: id, expenseUseCase: useCase)
    viewController.coordinator = coordinator
    
    return viewController
  }
}
