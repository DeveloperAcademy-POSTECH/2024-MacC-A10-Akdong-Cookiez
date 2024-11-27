//
//  JudgmentView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import SwiftUI
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
  
  private var buyConfettiHostingController: UIHostingController<ConfettiView>?
  private var notBuyConfettiHostingController: UIHostingController<ConfettiView>?
  
  private let buyingConfettiViewModel = CounterViewModel()
  private let notbuyingConfettiViewModel = CounterViewModel()
  
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
    
    addConfettiView(for: buyButton, imageName: "confettiOmark", isLeft: false, confettiHostingController: &buyConfettiHostingController, viewModel: buyingConfettiViewModel)
    addConfettiView(for: notBuyButton, imageName: "confettiXmark", isLeft: true, confettiHostingController: &notBuyConfettiHostingController, viewModel: notbuyingConfettiViewModel)
    
    buyButton.addTarget(self, action: #selector(tappedBuyingDecisionButton(_:)), for: .touchUpInside)
    notBuyButton.addTarget(self, action: #selector(tappedBuyingDecisionButton(_:)), for: .touchUpInside)
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
  
  private func addConfettiView(for button: UIButton, imageName: String, isLeft: Bool, confettiHostingController: inout UIHostingController<ConfettiView>?, viewModel: CounterViewModel) {
    // ConfettiView 생성
    let confettiView = ConfettiView(viewModel: viewModel, isLeft: isLeft, imageName: imageName)
    confettiHostingController = UIHostingController(rootView: confettiView)
    
    if let confettiHostingView = confettiHostingController?.view {
      confettiHostingView.translatesAutoresizingMaskIntoConstraints = false
      confettiHostingView.isUserInteractionEnabled = false // 터치 이벤트 방해 금지
      confettiHostingView.backgroundColor = .clear
      addSubview(confettiHostingView)
      
      NSLayoutConstraint.activate([
        confettiHostingView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
        confettiHostingView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
        confettiHostingView.topAnchor.constraint(equalTo: button.topAnchor),
        confettiHostingView.bottomAnchor.constraint(equalTo: button.bottomAnchor)
      ])
    }
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
  
  @objc private func tappedBuyingDecisionButton(_ sender: UIButton) {
//    self.isUserInteractionEnabled = false
    let confettiViewModelToUse = (sender == buyButton) ? buyingConfettiViewModel : notbuyingConfettiViewModel
    
    // 첫 번째 counter 증가
    DispatchQueue.main.async {
      confettiViewModelToUse.counter += 1
    }

    // 0.2초 후 두 번째 counter 증가
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
      guard let self else { return }
      confettiViewModelToUse.counter += 1
      self.fadeOutAndTransition()
    }

    // 1.3초 후 화면 이동
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) { [weak self] in
      guard let self else { return }
      self.onActionCompletedDecision?(sender == self.buyButton)
    }
  }
  
  private func fadeOutAndTransition() {
    UIView.animate(withDuration: 1.3, animations: {
          // 뷰의 투명도를 0으로 설정 (페이드 아웃 효과)
        self.paper.alpha = 0.0
        self.birdsReactionTitleLabel.alpha = 0.0
        self.paperTitleLabel.alpha = 0.0
        self.reactionCollectionView.alpha = 0.0
        self.decisionLabel.alpha = 0.0
        self.decisionStack.alpha = 0.0
        self.gradientView.alpha = 0.0
        
      }, completion: { _ in
          // 애니메이션 완료 후 화면 전환 처리
          self.onActionCompletedDecision?(true) // 화면 전환 로직
      })
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
