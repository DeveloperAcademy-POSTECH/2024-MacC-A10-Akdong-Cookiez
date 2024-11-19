//
//  JudgmentEditFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

protocol JudgmentEditFactory {
  func create(coordinator: JudgmentCoordinator) -> UIViewController
  func dismiss(editViewController viewController: UIViewController)
}
