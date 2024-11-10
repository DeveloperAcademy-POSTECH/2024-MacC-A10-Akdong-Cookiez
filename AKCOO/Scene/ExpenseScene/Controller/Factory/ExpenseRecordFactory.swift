//
//  ExpenseRecordFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

protocol ExpenseRecordFactory {
  var useCase: ExpenseUseCase { get set }
  func create(travelId id: String, coordinator: TravelCoordinator) -> UIViewController
}
