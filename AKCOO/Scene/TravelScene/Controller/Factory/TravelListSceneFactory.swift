//
//  TravelListSceneFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

protocol TravelListSceneFactory {
  func create(coordinator: any TravelCoordinator, useCase: TravelUseCase) -> UIViewController
}
