//
//  JudgmentView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class JudgmentView: UIView {
  
  var blueBackgroundView = UIView().set {
    $0.backgroundColor = .akColor(.akBlue400)
  }
  
  let paperTitleLabel = UILabel().set {
    $0.text = "입력정보"
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = .akColor(.white)
  }
  
  let paper = ClosedPaperView().set()
  
  let birdsReactionTitleLabel = UILabel().set {
    $0.text = "지출판단 결과"
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = .akColor(.white)
  }
  
  let reactionCollectionView = BirdReactionCollectionView().set()
  
  let judgmentKRW = BirdReactionTextView().set()
  let judgmentLocals = BirdReactionTextView().set()
  let judgmentBefore = BirdReactionTextView().set()
  
  let decisionLabel = UILabel().set {
    $0.text = "구매 결정을 기록해\n나의 판단 유형을 확인해 보세요!"
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = .akColor(.white)
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }
  
  let gradientView = GradientView(style: .bottomShade).set()
  
  let decisionStack = UIStackView().set {
    $0.axis = .horizontal
    $0.alignment = .center
    $0.spacing = 9
  }
  
  lazy var buyButton: UIButton = self.createCustomButton(title: "살래요")
  lazy var notBuyButton: UIButton = self.createCustomButton(title: "안 살래요")
  
  var onActionCompletedDecision: ((Bool) -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
  
  private func setupViews() {
    addSubview(blueBackgroundView)
    addSubview(reactionCollectionView)
    addSubview(paperTitleLabel)
    addSubview(paper)
    addSubview(gradientView)
    addSubview(birdsReactionTitleLabel)
    
    addSubview(decisionLabel)
    addSubview(decisionStack)
    
    decisionStack.addArrangedSubview(notBuyButton)
    decisionStack.addArrangedSubview(buyButton)
    
    buyButton.addTarget(self, action: #selector(tappedDecisionButton(_:)), for: .touchUpInside)
    notBuyButton.addTarget(self, action: #selector(tappedDecisionButton(_:)), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    let infoTitleTopPadding: CGFloat = 8
    let titleLeading: CGFloat = 38
    let birdStackHorizentalPadding: CGFloat = 16
    let buttonHorizentalPadding: CGFloat = 33
    
    NSLayoutConstraint.activate([
      blueBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      blueBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      blueBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      blueBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      paperTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
      paperTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleLeading),
      
      paper.topAnchor.constraint(equalTo: paperTitleLabel.bottomAnchor, constant: infoTitleTopPadding),
      paper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: birdStackHorizentalPadding),
      paper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -birdStackHorizentalPadding),
      
      birdsReactionTitleLabel.topAnchor.constraint(equalTo: paper.bottomAnchor, constant: birdStackHorizentalPadding),
      birdsReactionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleLeading),
      
      reactionCollectionView.topAnchor.constraint(equalTo: birdsReactionTitleLabel.bottomAnchor, constant: infoTitleTopPadding),
      reactionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      reactionCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      reactionCollectionView.bottomAnchor.constraint(equalTo: decisionStack.topAnchor),
      
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
      gradientView.centerXAnchor.constraint(equalTo: centerXAnchor),
      gradientView.heightAnchor.constraint(equalToConstant: 170),
      gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      decisionLabel.bottomAnchor.constraint(equalTo: decisionStack.topAnchor, constant: -12),
      decisionLabel.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
      
      decisionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: buttonHorizentalPadding),
      decisionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -buttonHorizentalPadding),
      decisionStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
    ])
  }
  
  func configure(
    userQuesion: UserQuestion,
    birds: [BirdModel]
  ) {
    paper.configure(
      userQuestion: userQuesion
    )
    
    reactionCollectionView.configure(
      with: birds,
      userAmount: userQuesion.amount
    )
  }
  
  private func createCustomButton(title: String) -> UIButton {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 37.5, bottom: 18, trailing: 37.5)
    let button = UIButton(configuration: configuration)
    return button.set {
      $0.setTitle(title, for: .normal)
      $0.configuration?.baseForegroundColor = .akColor(.akBlue500)
      $0.akFont(.gmarketBold18)
      $0.configuration?.background.backgroundColor = .akColor(.white)
      $0.layer.cornerRadius = 20
      $0.layer.masksToBounds = true // 라운드 처리를 위한 마스크
    }
  }
  
  @objc private func tappedDecisionButton(_ sender: UIButton) {
    onActionCompletedDecision?(sender == buyButton)
    print("?????")
  }
}

#Preview {
  let view = JudgmentView()
  view.configure(
    userQuesion: .init(
      country: .init(name: "스위스", currency: .init(unitTitle: "프랑", unit: 1575.64)), category: "어쩌구", amount: 20000),
    birds: []
  )
  return view
}
