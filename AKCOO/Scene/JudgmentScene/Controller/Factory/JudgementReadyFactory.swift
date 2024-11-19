//
//  JudgmentReadyFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

protocol JudgmentReadyFactory {
  func create(coordinator: JudgmentCoordinator) -> UIViewController
}
