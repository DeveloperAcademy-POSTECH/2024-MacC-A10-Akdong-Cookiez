//
//  TravelNewSceneFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

protocol TravelNewSceneFactory {
  func create(coordinator: any TravelNewCoordinator, useCase: TravelUseCase) -> UIViewController
}
