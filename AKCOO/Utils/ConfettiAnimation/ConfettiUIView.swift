//
//  ConfettiUIView.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI
import UIKit

/*
  사용방법.. 을 남기지 못해 죄송합니다 하하
  버튼이 동작하지 않는 이슈가 있어서 마무리를 못했어요 하하
*/

// UIKit에서 사용할 UIView Wrapping
class ConfettiUIView: UIView {
  private var hostingController: UIHostingController<ConfettiView>?
  
  init(imageName: String?) {
    super.init(frame: .zero)
    
    // SwiftUI ConfettiView를 HostingController로 Wrapping
    let confettiView = ConfettiView(imageName: imageName)
    hostingController = UIHostingController(rootView: confettiView)
    
    if let hostingView = hostingController?.view {
      addSubview(hostingView)
      hostingView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
        hostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
        hostingView.topAnchor.constraint(equalTo: topAnchor),
        hostingView.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
