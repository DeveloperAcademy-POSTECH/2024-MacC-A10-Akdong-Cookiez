//
//  GradientStyle+bottomShade.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

extension GradientStyle {
  static var bottomShade: GradientStyle {
    return GradientStyle(
      colors: [
        GradientColor(location: 0, color: UIColor.white.withAlphaComponent(0)),
        GradientColor(location: 1, color: .white), //
        GradientColor(location: 1, color: .white), //
        GradientColor(location: 1, color: .white), //
        GradientColor(location: 1, color: .white.withAlphaComponent(1)) // blue로 변경
      ],
      direction: .vertical
    )
  }
}
