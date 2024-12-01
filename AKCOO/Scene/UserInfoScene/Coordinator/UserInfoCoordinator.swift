//
//  UserInfoCoordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

protocol UserInfoCoordinator: Coordinator {
  func startUserInfo(push: UIViewController)
  func completedUserInfo()
}
