//
//  GuideViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import UIKit

class GuideViewController: UIViewController {
  weak var coordinator: GuideCoordinator?
  private let guideUseCase: GuideUseCase
  
  // MARK: View
  private var guideView: GuideView! {
    return view as? GuideView
  }
  
  init(guideUseCase: GuideUseCase) {
    self.guideUseCase = guideUseCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = GuideView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    onAction()
  }
  
  private func onAction() {
    guideView.onActionUserInfoTapped = { [weak self] in
      guard let self else { return }
      self.coordinator?.startUserInfo()
    }
    
    guideView.onActionJudgmentTapped = { [weak self] in
      guard let self else { return }
      self.coordinator?.startJudgmentReady(presenting: self)
    }
  }
}

#Preview {
  GuideViewController(guideUseCase: GuideUseCaseMock())
}
