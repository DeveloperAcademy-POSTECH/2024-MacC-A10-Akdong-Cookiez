//
//  UIView+Setter.swift
//  AKCOO
//
//  Created by Anjin on 11/8/24.
//

import UIKit

protocol UIViewSetter {}

extension UIViewSetter where Self: UIView {
  /// UIView 속성을 설장하기 위한 method
  ///
  /// 사용 예시:
  /// ```swift
  /// private let spendInputView = UIView().set {
  ///     $0.backgroundColor = .systemGray5
  ///     $0.layer.cornerRadius = 20
  /// }
  /// ```
  func set(_ configure: (Self) -> Void = { _ in }) -> Self {
    configure(self)
    self.translatesAutoresizingMaskIntoConstraints = false
    return self
  }
}

extension UIView: UIViewSetter {}
