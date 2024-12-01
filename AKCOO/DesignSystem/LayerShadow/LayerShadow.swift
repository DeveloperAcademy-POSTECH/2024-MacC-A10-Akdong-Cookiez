//
//  LayerShadow.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

struct LayerShadow {
  let color: CGColor?
  let opacity: Float
  let offset: CGSize
  let radius: CGFloat
  let path: CGPath?
  
  static var none: LayerShadow {
    return LayerShadow(
      color: nil,
      opacity: 0,
      offset: .zero,
      radius: 0,
      path: nil
    )
  }
  
  static func from(_ layer: CALayer) -> LayerShadow {
    return LayerShadow(
      color: layer.shadowColor,
      opacity: layer.shadowOpacity,
      offset: layer.shadowOffset,
      radius: layer.shadowRadius,
      path: layer.shadowPath
    )
  }
}

extension CALayer {
  func apply(_ shadow: LayerShadow) {
    shadowColor = shadow.color
    shadowOpacity = shadow.opacity
    shadowOffset = shadow.offset
    shadowRadius = shadow.radius
    shadowPath = shadow.path
  }
}
