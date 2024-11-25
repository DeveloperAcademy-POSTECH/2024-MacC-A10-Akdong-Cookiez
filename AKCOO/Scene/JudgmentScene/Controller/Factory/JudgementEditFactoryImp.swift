//
//  JudgmentEditFactoryImp.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import Foundation

import UIKit

struct JudgmentEditFactoryImp: JudgmentEditFactory {
  let useCase: JudgmentUseCase
  
  func create(coordinator: any JudgmentCoordinator, paperModel: PaperModel, selectedCategory: String, userAmount: String, delegate: any JudgmentEditViewControllerDelegate) -> UIViewController {
    let readyController = JudgmentEditViewController(
      judgmentUseCase: useCase, paperModel: paperModel, selectedCategory: selectedCategory, userAmount: userAmount)
    readyController.delegate = delegate
    readyController.coordinator = coordinator
    return readyController
  }
  
  func dismiss(editViewController viewController: UIViewController) {
    viewController.presentingViewController?.dismiss(animated: true)
  }
}
