//
//  ExpenseStatsFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

protocol ExpenseStatsFactory {
  func create(travelId id: String, coordinator: TravelCoordinator, useCase: ExpenseUseCase) -> UIViewController
}
