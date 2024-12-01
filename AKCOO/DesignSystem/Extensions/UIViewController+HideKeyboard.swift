//
//  UIViewController+HideKeyboard.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import UIKit

extension UIViewController {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
