//
//  ExpenseSceneFactory.swift
//  AKCOO
//
//  Created by 박혜운 on 11/9/24.
//

import UIKit

protocol ExpenseSceneFactory {
  func create(travelId id: String, recordViewController: UIViewController, statsViewController: UIViewController) -> UIViewController
  func dismisser(productViewController viewController: UIViewController)
}
