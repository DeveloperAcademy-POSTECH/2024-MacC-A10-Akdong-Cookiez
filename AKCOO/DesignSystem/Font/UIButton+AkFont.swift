//
//  UIButton+AkFont.swift
//  AKCOO
//
//  Created by 박혜운 on 11/23/24.
//

import UIKit

extension UIButton {
  func akFont(_ type: AKFontType, forState state: UIControl.State = .normal, dynamic: Bool = true) {
    let customFont = UIFont.akFont(type, dynamic: dynamic)
    
    if let currentTitle = self.title(for: state) {
      let attributedTitle = NSAttributedString(
        string: currentTitle,
        attributes: [.font: customFont]
      )
      self.setAttributedTitle(attributedTitle, for: state)
    }
  }
}
