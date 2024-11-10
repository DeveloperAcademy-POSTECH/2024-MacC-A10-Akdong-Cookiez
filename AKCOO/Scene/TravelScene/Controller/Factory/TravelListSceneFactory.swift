//
//  TravelListSceneFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

protocol TravelListSceneFactory {
  var useCase: TravelUseCase { get set }
  func create(coordinator: any TravelCoordinator) -> UIViewController
}
