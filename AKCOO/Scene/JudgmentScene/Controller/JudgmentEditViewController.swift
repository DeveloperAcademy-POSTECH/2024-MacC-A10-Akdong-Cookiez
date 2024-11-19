//
//  JudgmentEditViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class JudgmentEditViewController: UIViewController {
  weak var coordinator: JudgmentCoordinator?
  private let judgmentUseCase: JudgmentUseCase
  
  lazy var paper = OpenedPaperView().set()
  
  init(judgmentUseCase: JudgmentUseCase) {
    self.judgmentUseCase = judgmentUseCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    setConstraints()
    setEventDelegate()
  }
  
  private func setupView() {
    view.backgroundColor = .clear
    view.addSubview(paper)
  }
  
  private func setConstraints() {
    let paperPadding: CGFloat = 16
    
    NSLayoutConstraint.activate([
      paper.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      paper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paperPadding),
      paper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paperPadding)
    ])
  }
  
  private func setEventDelegate() {
    paper.tappedJudgmentButton = { [weak self] in
      guard let self else { return }
      self.coordinator?.completedEditPaper(editViewController: self)
    }
  }
}

#Preview {
  JudgmentEditViewController(judgmentUseCase: JudgmentUseCaseMock())
}
