//
//  GuideFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

protocol GuideFactory {
  func create(coordinator: GuideCoordinator) -> UIViewController
}
