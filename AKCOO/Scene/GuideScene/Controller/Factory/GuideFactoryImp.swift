//
//  GuideFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

struct GuideFactoryImp: GuideFactory {
  let useCase: GuideUseCase
  
  func create(coordinator: GuideCoordinator) -> UIViewController {
    let guideController = GuideViewController(guideUseCase: useCase)
    guideController.coordinator = coordinator
    return guideController
  }
}
