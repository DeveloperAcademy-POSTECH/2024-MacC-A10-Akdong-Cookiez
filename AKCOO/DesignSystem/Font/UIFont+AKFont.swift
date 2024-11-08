//
//  UIFont+AKFont.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import UIKit

extension UIFont {
  static func akFont(_ type: AKFontType, dynamic: Bool = true) -> UIFont {
    guard let customFont = UIFont(name: type.customFont, size: type.size) else {
      return UIFont.systemFont(ofSize: type.size) // 폰트가 없는 경우 기본 시스템 폰트로 대체
    }
    return dynamic ? UIFontMetrics.default.scaledFont(for: customFont) : customFont
  }
}
