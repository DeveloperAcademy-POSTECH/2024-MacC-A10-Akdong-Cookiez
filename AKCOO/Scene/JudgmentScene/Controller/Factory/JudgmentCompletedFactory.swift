//
//  JudgmentCompletedFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

protocol JudgmentCompletedFactory {
  func create(coordinator: JudgmentCoordinator, userQuestion: UserQuestion) -> UIViewController 
  func dismisser(judgmentCompletedViewController viewController: UIViewController)
}
