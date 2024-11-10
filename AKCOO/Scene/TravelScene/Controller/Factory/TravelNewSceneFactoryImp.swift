//
//  TravelNewSceneFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

struct TravelNewSceneFactoryImp: TravelNewSceneFactory {
  var useCase: any TravelUseCase
  
  init(useCase: any TravelUseCase) {
    self.useCase = useCase
  }
  
  func create(coordinator: any TravelNewCoordinator) -> UIViewController {
    let sceneController = TravelNewSceneController(useCase: useCase)
    sceneController.coordinator = coordinator
    return sceneController
  }
}
