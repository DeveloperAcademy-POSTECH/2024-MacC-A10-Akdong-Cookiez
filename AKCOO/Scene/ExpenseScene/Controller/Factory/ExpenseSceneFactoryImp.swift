//
//  ExpenseSceneFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

struct ExpenseSceneFactoryImp: ExpenseSceneFactory {
  func create(travelId id: String, coordinator: TravelCoordinator, useCase: ExpenseUseCase, recordViewController: UIViewController, statsViewController: UIViewController) -> UIViewController {
    let sceneController = ExpenseSceneController(recordViewController: recordViewController, statsViewController: statsViewController)
    return sceneController
  }
  
  func dismisser(productViewController viewController: UIViewController) {
    viewController.presentingViewController?.dismiss(animated: true)
  }
}
