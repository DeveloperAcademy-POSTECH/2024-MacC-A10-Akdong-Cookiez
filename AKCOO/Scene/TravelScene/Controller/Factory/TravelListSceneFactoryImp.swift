//
//  TravelListSceneFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

struct TravelListSceneFactoryImp: TravelListSceneFactory {
  var useCase: any TravelUseCase
  
  init(useCase: any TravelUseCase) {
    self.useCase = useCase
  }
  
  func create(coordinator: any TravelCoordinator) -> UIViewController {
    let sceneController = TravelListSceneController(useCase: useCase)
    sceneController.coordinator = coordinator
    
    return sceneController
  }
}