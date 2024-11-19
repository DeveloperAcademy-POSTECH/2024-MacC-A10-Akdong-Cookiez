//
//  GradientView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class GradientView: UIView {
  
  init(style: GradientStyle) {
    super.init(frame: .zero)
    isUserInteractionEnabled = false
    gradientLayer.colors = style.colors.map { $0.color.cgColor }
    gradientLayer.locations = style.colors.map { NSNumber(value: $0.location) }
    gradientLayer.startPoint = style.direction.startPoint
    gradientLayer.endPoint = style.direction.endPoint
    layer.addSublayer(gradientLayer)
  }
  
  required init?(coder aDecoder: NSCoder) {
    return nil
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = layer.bounds
  }
  
  private let gradientLayer = CAGradientLayer()
  
}
