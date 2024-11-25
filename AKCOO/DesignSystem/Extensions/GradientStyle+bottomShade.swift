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
        GradientColor(location: 0, color: .akColor(.akBlue400).withAlphaComponent(0)),
        GradientColor(location: 0.1, color: .akColor(.akBlue400))
      ],
      direction: .vertical
    )
  }
}
