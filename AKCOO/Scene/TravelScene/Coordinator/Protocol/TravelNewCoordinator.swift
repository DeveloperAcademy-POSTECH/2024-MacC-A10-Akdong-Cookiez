//
//  TravelNewCoordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import Foundation

protocol TravelNewCoordinator: Coordinator {
  func tappedSaveButton(new travel: Travel)
}
