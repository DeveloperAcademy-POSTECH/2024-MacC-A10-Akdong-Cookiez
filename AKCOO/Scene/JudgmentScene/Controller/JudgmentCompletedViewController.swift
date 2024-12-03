//
//  JudgmentCompletedViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

protocol JudgmentCompletedViewControllerDelegate: AnyObject, UIViewController {
  func onActionCompletedDecision()
}

class JudgmentCompletedViewController: UIViewController {
  weak var coordinator: JudgmentCoordinator?
  private let judgmentUseCase: JudgmentUseCase
  
  // MARK: View
  private var judgmentView: JudgmentView! {
    return view as? JudgmentView
  }
  
  private var selectedCountryDetail: CountryDetail
  private var userQuestion: UserQuestion
  private var birds: [BirdModel]?
  
  weak var delegate: JudgmentCompletedViewControllerDelegate?
  
  init(
    judgmentUseCase: JudgmentUseCase,
    selectedCountryDetail: CountryDetail,
    userQuestion: UserQuestion
  ) {
    self.judgmentUseCase = judgmentUseCase
    self.selectedCountryDetail = selectedCountryDetail
    self.userQuestion = userQuestion
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = JudgmentView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Task {
      setupViews()
      await configure()
      onAction()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.judgmentView.reactionCollectionView.collectionView.reloadData()
  }
  
  private func setupViews() {
    judgmentView.paper.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedPaper)))
  }
  
  private func configure() async {
    let birds: [BirdModel]
    switch await judgmentUseCase.getBirdsJudgment(selectedCountryDetail: selectedCountryDetail, userQuestion: userQuestion) {
    case .success(let birdsData):
      birds = birdsData
    case .failure:
      birds = []
      // TODO: - Error 처리
    }
    
    judgmentView.configure(
      userQuesion: self.userQuestion,
      birds: birds
    )
    
    self.birds = birds
  }
  
  private func onAction() {
    judgmentView.onActionCompletedDecision = { [weak self] buying in
      guard let self, let birds else { return }
      
      let birdJudgmentDictionary: [String: JudgmentType] = Dictionary(
        uniqueKeysWithValues: birds.map { ($0.name, $0.judgment ? .buying : .notBuying) }
      )
      
      let newRecord = UserRecord.init(
        userQuestion: userQuestion,
        userJudgment: buying ? .buying : .notBuying,
        externalJudgment: birdJudgmentDictionary
      )
      
      // TODO: - 분기처리
      _ = judgmentUseCase.save(record: newRecord)
      self.delegate?.onActionCompletedDecision()
      coordinator?.completedJudgment(judgmentViewController: self)
    }
  }
  
  @objc func tappedPaper() {
    guard case .success(let paperModel) = judgmentUseCase.getPaperModel(selectedCountryDetail: selectedCountryDetail) else { return }
    coordinator?.startEditPaper(
      presenting: self,
      paperModel: paperModel,
      selectedCategory: userQuestion.category,
      userAmount: userQuestion.amount.changeToStringNonZeroDot
    )
  }
}

extension JudgmentCompletedViewController: JudgmentEditViewControllerDelegate {
  func onActionChangingUserQuestion(_ userQuestion: UserQuestion) {
    Task {
      let birds: [BirdModel]
      switch await judgmentUseCase.getBirdsJudgment(selectedCountryDetail: selectedCountryDetail, userQuestion: userQuestion) {
      case .success(let birdsData):
        birds = birdsData
      case .failure:
        birds = []
        // TODO: - Error 처리
      }
      
      self.userQuestion = userQuestion
      
      judgmentView.configure(
        userQuesion: self.userQuestion,
        birds: birds
      )
      
      self.birds = birds
    }
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
    userQuestion: userQuestion,
    standards: items
  )
  let localJudgment = CountryAverageJudgment(
    userQuestion: userQuestion,
    standards: items
  )
  
  let previousJudgment = PreviousJudgment(
    userQuestion: userQuestion,
    standards: nil
  )
  
  let birds: [BirdModel] = [
    ForeignBird(judgment: forignJudgment),
    LocalBird(
      birdCountry: country,
      judgment: localJudgment
    ),
    PreviousBird(judgment: previousJudgment)
  ]
  
  JudgmentCompletedViewController(
    judgmentUseCase: JudgmentUseCaseMock(), selectedCountryDetail: .init(country: .init(name: "베트남", currency: .init(unitTitle: "동", unit: 0)), items: []),
    userQuestion: .init(
      country: country,
      category: "식당",
      amount: 1000000
    )
  )
}
