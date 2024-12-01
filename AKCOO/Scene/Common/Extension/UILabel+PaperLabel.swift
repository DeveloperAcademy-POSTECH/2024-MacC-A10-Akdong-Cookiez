//
//  UILabel+.swift
//  AKCOO
//
//  Created by 박혜운 on 11/22/24.
//

import UIKit

extension UILabel {
  static func paperLabel(with title: String) -> UILabel {
    let label = UILabel()
    
    let fullText = "\(title)*"
    let attributedString = NSMutableAttributedString(string: fullText)
    
    attributedString.addAttribute(
      .foregroundColor,
      value: UIColor.black,
      range: (fullText as NSString).range(of: title)
    )
    
    attributedString.addAttribute(
      .foregroundColor,
      value: UIColor.gray,
      range: (fullText as NSString).range(of: "*")
    )
    
    label.attributedText = attributedString
    label.font = .akFont(.gmarketMedium14)
    
    return label
  }
}
