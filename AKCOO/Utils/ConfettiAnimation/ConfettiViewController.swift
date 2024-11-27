//
//  ConfettiViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/28/24.
//

import UIKit
import SwiftUI

// MARK: - 테스트를 위한 예시 코드입니다 
class ConfettiViewController: UIViewController {
  private var viewModel = CounterViewModel() // Shared ViewModel
  private var hostingController: UIHostingController<ConfettiView>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // SwiftUI View 생성 및 ViewModel 전달
    let confettiView = ConfettiView(viewModel: viewModel, isLeft: true, imageName: "confettiOmark")
    hostingController = UIHostingController(rootView: confettiView)
    
    if let hostingView = hostingController?.view {
      hostingView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(hostingView)
      
      NSLayoutConstraint.activate([
        hostingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        hostingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        hostingView.topAnchor.constraint(equalTo: view.topAnchor),
        hostingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
    }
    
    // UIKit Button 추가
    let button = UIButton(type: .system)
    button.setTitle("Show Confetti", for: .normal)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
    ])
  }
  
  @objc private func buttonTapped() {
    // Counter 증가
    viewModel.counter += 1
  }
}

#Preview {
  ConfettiViewController()
}
