//
//  ExpenseRecordFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

struct ExpenseRecordFactoryImp: ExpenseRecordFactory {
  func create(travelId id: String, coordinator: TravelCoordinator, useCase: ExpenseUseCase) -> UIViewController {
    let viewController = ExpenseRecordViewController(travelId: id, expenseUseCase: useCase)
    viewController.coordinator = coordinator
    
    return viewController
  }
}
