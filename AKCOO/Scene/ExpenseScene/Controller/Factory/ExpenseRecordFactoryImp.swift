//
//  ExpenseRecordFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

struct ExpenseRecordFactoryImp: ExpenseRecordFactory {
  var useCase: any ExpenseUseCase
  
  init(useCase: any ExpenseUseCase) {
    self.useCase = useCase
  }
  
  func create(travelId id: String, coordinator: TravelCoordinator) -> UIViewController {
    let viewController = ExpenseRecordViewController(travelId: id, expenseUseCase: useCase)
    viewController.coordinator = coordinator
    
    return viewController
  }
}
