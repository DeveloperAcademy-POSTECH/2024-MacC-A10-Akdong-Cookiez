//
//  JudgmentView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class JudgmentView: UIView {
  
  let paperTitleLabel = UILabel().set {
    $0.text = "입력정보"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
  }
  
  let paper = ClosedPaperView().set()
  
  let birdsReactionTitleLabel = UILabel().set {
    $0.text = "지출판단결과"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
  }
  
  let reactionStackView = ReactionBirdsCollectionView().set()
  
  let judgmentKRW = ReactionBirdTextView().set()
  let judgmentLocals = ReactionBirdTextView().set()
  let judgmentBefore = ReactionBirdTextView().set()
  
  let decisionLabel = UILabel().set {
    $0.text = "구매 결정을 기록해\n내 소비 성향을 확인해 보세요!"
    $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    $0.textColor = .gray
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }
  
  let gradientView = GradientView(style: .bottomShade).set()
  
  let decisionStack = UIStackView().set {
    $0.axis = .horizontal
    $0.alignment = .center
    $0.distribution = .fillEqually
    $0.spacing = 16
  }
  
  let buyButton = UIButton(type: .system).set {
    $0.setTitle("살래요", for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    $0.setTitleColor(.systemBlue, for: .normal)
  }
  
  let notBuyButton = UIButton(type: .system).set {
    $0.setTitle("안살래요", for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    $0.setTitleColor(.systemRed, for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
    setConstraints()
  }
  
  private func setupView() {
    reactionStackView.configure(with: [judgmentKRW, judgmentLocals, judgmentBefore])
    
    decisionStack.addArrangedSubview(notBuyButton)
    decisionStack.addArrangedSubview(buyButton)
    
    gradientView.addSubview(decisionLabel)
    
    addSubview(paperTitleLabel)
    addSubview(paper)
    
    addSubview(birdsReactionTitleLabel)
    addSubview(reactionStackView)
    
    addSubview(gradientView)
    addSubview(decisionStack)
  }
  
  private func setConstraints() {
    let infoTitleTopPadding: CGFloat = 1
    let titleLeading: CGFloat = 38
    let topPadding: CGFloat = 16
    
    NSLayoutConstraint.activate([
      paperTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      paperTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleLeading),
      
      paper.topAnchor.constraint(equalTo: paperTitleLabel.bottomAnchor, constant: infoTitleTopPadding),
      paper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: topPadding),
      paper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -topPadding),
      
      birdsReactionTitleLabel.topAnchor.constraint(equalTo: paper.bottomAnchor, constant: topPadding),
      birdsReactionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleLeading),
      
      reactionStackView.topAnchor.constraint(equalTo: birdsReactionTitleLabel.bottomAnchor, constant: infoTitleTopPadding),
      reactionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: topPadding),
      reactionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -topPadding),
      reactionStackView.bottomAnchor.constraint(equalTo: decisionLabel.bottomAnchor),
      
      decisionLabel.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -15),
      decisionLabel.centerXAnchor.constraint(equalTo: gradientView.centerXAnchor),
      
      gradientView.bottomAnchor.constraint(equalTo: decisionStack.topAnchor, constant: -15),
      gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
      gradientView.centerXAnchor.constraint(equalTo: centerXAnchor),
      gradientView.heightAnchor.constraint(equalToConstant: 80),
      
      decisionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: topPadding),
      decisionStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -topPadding),
      decisionStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

#Preview {
  JudgmentView()
}
