//
//  TravelNewCoordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import Foundation

protocol TravelNewCoordinatorDelegate: AnyObject {
  func newTravel(_ data: Travel)
}

protocol TravelNewCoordinator: Coordinator {
  var parents: TravelNewCoordinatorDelegate? { get set }
  func tappedSaveButton(new travel: Travel)
}
