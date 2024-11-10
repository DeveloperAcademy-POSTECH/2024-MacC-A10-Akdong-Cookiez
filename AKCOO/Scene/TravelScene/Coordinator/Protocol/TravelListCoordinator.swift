//
//  TravelListCoordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 11/10/24.
//

import UIKit

protocol TravelListCoordinator: Coordinator {
  func tappedPlusButton()
  func presentExpense(travelId id: String, cellIndexPath: IndexPath?, form presenting: UIViewController)
}
