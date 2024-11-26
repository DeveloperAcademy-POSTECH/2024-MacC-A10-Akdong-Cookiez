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
  
  private var userQuestion: UserQuestion
  private var birds: [BirdModel]
  
  init(
    judgmentUseCase: JudgmentUseCase,
    userQuestion: UserQuestion
  ) {
    self.judgmentUseCase = judgmentUseCase
    self.userQuestion = userQuestion
    
    switch judgmentUseCase.getBirdsJudgment(userQuestion: userQuestion) {
    case .success(let birds):
      self.birds = birds
    case .failure:
      self.birds = []
      // TODO: - Error 처리
    }
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
    setupViews()
    
    judgmentView.configure(
      userQuesion: self.userQuestion,
      birds: self.birds
    )
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.judgmentView.reactionStackView.collectionView.reloadData()
  }
  
  private func setupViews() {
    view.backgroundColor = .clear
    judgmentView.paper.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedPaper)))
  }
  
  @objc func tappedPaper() {
    coordinator?.startEditPaper(presenting: self)
  }
}

#Preview {
  let userQuestionAmount: Double = 1000000
  let items: [Item] = []
  let country = CountryProfile.init(
    name: "베트남",
    currency: .init(unitTitle: "동", unit: 1)
  )
  let userQuestion = UserQuestion(
    country: country,
    category: "숙박",
    amount: userQuestionAmount
  )
  
  let forignJudgment = CountryAverageJudgment(
    userAmount: userQuestionAmount,
    standards: items
  )
  let localJudgment = CountryAverageJudgment(
    userAmount: userQuestionAmount,
    standards: items
  )
  
  let previousJudgment = PreviousJudgment(
    userAmount: userQuestionAmount,
    standards: nil
  )
  
  let birds: [BirdModel] = [
    ForeignBird(
      country: country,
      judgment: forignJudgment
    ),
    LocalBird(
      country: country,
      judgment: localJudgment
    ),
    PreviousBird(
      userQuestion: userQuestion,
      judgment: previousJudgment
    )
  ]
  
  return JudgmentCompletedViewController(
    judgmentUseCase: JudgmentUseCaseMock(),
    userQuestion: .init(
      country: country,
      category: "식당",
      amount: 1000000
    )
  )
}
