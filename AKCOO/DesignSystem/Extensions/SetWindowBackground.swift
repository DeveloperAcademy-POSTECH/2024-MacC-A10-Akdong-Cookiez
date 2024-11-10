//
//  SetWindowBackground.swift
//  AKCOO
//
//  Created by 박혜운 on 11/8/24.
//

import UIKit

func setWindowBackgroundColor(_ color: UIColor) {
  guard 
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
    let window = windowScene.windows.first 
  else { return }
  window.backgroundColor = color
}
