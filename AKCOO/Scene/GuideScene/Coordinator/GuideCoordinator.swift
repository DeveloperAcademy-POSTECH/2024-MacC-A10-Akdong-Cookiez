//
//  GuideCoordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

protocol GuideCoordinator: Coordinator {
  func startGuide(presenting: UIViewController)
  func startJudgment(presenting: UIViewController)
}
