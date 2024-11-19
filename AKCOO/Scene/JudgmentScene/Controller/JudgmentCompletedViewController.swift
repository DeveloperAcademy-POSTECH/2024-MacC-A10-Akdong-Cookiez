//
//  JudgmentCompletedViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class JudgmentCompletedViewController: UIViewController {
  weak var coordinator: JudgmentCoordinator?
  private let judgmentUseCase: JudgmentUseCase
  
  // MARK: View
  private var judgmentView: JudgmentView! {
    return view as? JudgmentView
  }
  
  init(judgmentUseCase: JudgmentUseCase) {
    self.judgmentUseCase = judgmentUseCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = JudgmentView()
    view.backgroundColor = .green
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.judgmentView.reactionStackView.collectionView.reloadData()
  }
  
  private func setupView() {
    view.backgroundColor = .clear
    judgmentView.paper.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedPaper)))
  }
  
  @objc func tappedPaper() {
    coordinator?.startEditPaper(presenting: self)
  }
}

#Preview {
  JudgmentCompletedViewController(judgmentUseCase: JudgmentUseCaseMock())
}
