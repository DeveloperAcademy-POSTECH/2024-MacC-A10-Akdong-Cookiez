//
//  Font+fromUIFont.swift
//  AKCOO
//
//  Created by Anjin on 12/2/24.
//

import SwiftUI

extension Font {
  static func from(uiFont: UIFont) -> Font {
    return Font.custom(uiFont.fontName, size: uiFont.pointSize)
  }
}
