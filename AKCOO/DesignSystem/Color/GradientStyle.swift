//
//  GradientStyle.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

struct GradientStyle {
  let colors: [GradientColor]
  let direction: GradientDirection
}

struct GradientColor {
  let location: Float
  let color: UIColor
}

struct GradientDirection {
  let startPoint: CGPoint
  let endPoint: CGPoint
}

extension GradientDirection {
  static var horizontal: GradientDirection {
    return GradientDirection(
      startPoint: CGPoint(x: 0, y: 0.5),
      endPoint: CGPoint(x: 1, y: 0.5)
    )
  }
  static var vertical: GradientDirection {
    return GradientDirection(
      startPoint: CGPoint(x: 0.5, y: 0),
      endPoint: CGPoint(x: 0.5, y: 1)
    )
  }
}
