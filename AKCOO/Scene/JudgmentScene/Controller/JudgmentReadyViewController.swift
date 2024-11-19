//
//  JudgmentSettingViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class JudgmentReadyViewController: UIViewController {
  weak var coordinator: JudgmentCoordinator?
  private let judgmentUseCase: JudgmentUseCase
  
  // MARK: View
  private var judgmentReadyView: JudgmentReadyView! {
    return view as? JudgmentReadyView
  }
  
  init(judgmentUseCase: JudgmentUseCase) {
    self.judgmentUseCase = judgmentUseCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = JudgmentReadyView()
    view.backgroundColor = .green
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  private func setupView() {
    view.backgroundColor = .blue
    judgmentReadyView.paper.readyButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedPaper)))
  }
  
  @objc func tappedPaper() {
    coordinator?.startJudgment(presenting: self)
  }
}

#Preview {
  JudgmentReadyViewController(judgmentUseCase: JudgmentUseCaseMock())
}
