//
//  TravelNewSceneFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

struct TravelNewSceneFactoryImp: TravelNewSceneFactory {
  func create(coordinator: any TravelNewCoordinator, useCase: TravelUseCase) -> UIViewController {
    let sceneController = TravelNewSceneController(useCase: useCase)
    sceneController.coordinator = coordinator
    return sceneController
  }
}
