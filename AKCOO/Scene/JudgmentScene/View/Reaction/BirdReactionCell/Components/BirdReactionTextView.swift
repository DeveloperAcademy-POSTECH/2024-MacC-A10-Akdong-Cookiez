//
//  BirdReactionTextView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class BirdReactionTextView: UIView {
  private let backgroundView = UIView(frame: .zero).set {
    $0.accessibilityIdentifier = "BackgroundView"
    $0.clipsToBounds = true
  }
  
  private let opinionLabel = UILabel().set {
    $0.accessibilityIdentifier = "TitleLabel"
    $0.font = .akFont(.gmarketBold16)
    $0.textAlignment = .left
    $0.adjustsFontForContentSizeCategory = true
  }
  
  let nameTextView = UIView().set {
    $0.backgroundColor = .clear
  }
  
  private let nameLabel = UILabel().set {
    $0.accessibilityIdentifier = "OpinionLabel"
    $0.font = .akFont(.gmarketMedium13)
    $0.textColor = .black
  }
  
  let downImageView = UIImageView().set {
    $0.image = UIImage(systemName: "chevron.down")
    $0.tintColor = .akColor(.black)
    $0.contentMode = .scaleAspectFit
  }
  
  private let verticalLineView = UIView().set {
    $0.accessibilityIdentifier = "VerticalLineView"
    $0.backgroundColor = .akColor(.black)
    $0.layer.cornerRadius = 2
  }
  
  private let detailLabel = UILabel().set {
    $0.accessibilityIdentifier = "DetailLabel"
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 5
    $0.attributedText = NSAttributedString(
      string: $0.text ?? "",
      attributes: [.paragraphStyle: paragraphStyle]
    )
    $0.font = .akFont(.gmarketMedium13)
    $0.numberOfLines = 0
    $0.textColor = .black
    $0.alpha = 0
  }
  
  private let detailGraphView: DetailGraphView = DetailGraphView().set()
  
  private var isExpanded = false
  private var backgroundBottomClosedConstraint: NSLayoutConstraint?
  private var opinionLeadingConstraint: NSLayoutConstraint?
  
  private var detailGraphVetricalOpenedConstraint: [NSLayoutConstraint]?
  private var detailVetricalOpenedConstraint: [NSLayoutConstraint]?
  
  private let horizentalPadding: CGFloat = 30
  private let largeHorizentalPadding: CGFloat = 50
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    setupConstraints(isExpanded: false)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
    setupConstraints(isExpanded: false)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
    print("layoutSubviews 실행 후 BirdReactionTextView frame: \(self.frame)")
  }
  
  private func setupViews() {
    addSubview(backgroundView)
    backgroundView.addSubview(opinionLabel)
    backgroundView.addSubview(nameTextView)
    backgroundView.addSubview(verticalLineView)
    backgroundView.addSubview(detailLabel)
    backgroundView.addSubview(detailGraphView)
    
    nameTextView.addSubview(nameLabel)
    nameTextView.addSubview(downImageView)

  }
  
  private func setupConstraints() {
    let verticalPadding: CGFloat = 20
    let horizentalPadding: CGFloat = 30
    
    let trailingConstraint = opinionLabel.trailingAnchor.constraint(lessThanOrEqualTo: backgroundView.trailingAnchor, constant: -horizentalPadding)
    trailingConstraint.priority = .defaultHigh // 우선순위 낮추기
    
    let backgroundBottomClosedConstraint = backgroundView.bottomAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: verticalPadding)
    opinionLeadingConstraint = opinionLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: horizentalPadding)
    
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundBottomClosedConstraint,
      
      opinionLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: verticalPadding),
      opinionLeadingConstraint!,
      trailingConstraint,
      
      nameTextView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
      nameTextView.topAnchor.constraint(equalTo: opinionLabel.bottomAnchor, constant: 8),
      nameTextView.leadingAnchor.constraint(equalTo: opinionLabel.leadingAnchor, constant: 7),
      nameTextView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      nameTextView.trailingAnchor.constraint(equalTo: downImageView.trailingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: downImageView.leadingAnchor, constant: -4),
      nameTextView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
      downImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
      
      verticalLineView.widthAnchor.constraint(equalToConstant: 2),
      verticalLineView.topAnchor.constraint(equalTo: detailLabel.topAnchor),
      verticalLineView.bottomAnchor.constraint(equalTo: detailLabel.bottomAnchor),
      verticalLineView.leadingAnchor.constraint(equalTo: detailLabel.leadingAnchor, constant: -8),
      
      detailLabel.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 10),
      detailGraphView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 6),
      detailGraphView.leadingAnchor.constraint(equalTo: opinionLabel.leadingAnchor), // 임시
      detailGraphView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33) // 임시
    ])
    
    self.backgroundBottomClosedConstraint = backgroundBottomClosedConstraint
    opinionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    opinionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    detailLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    detailLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    
    setupClosedConstraints()
  }
  
  func setupClosedConstraints() {
    let verticalPadding: CGFloat = 20
    
    let detailTrailingConstraint = detailLabel.trailingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: backgroundView.trailingAnchor, multiplier: -verticalPadding)
    detailTrailingConstraint.priority = .defaultHigh
    
    self.detailVetricalOpenedConstraint = [
      detailLabel.leadingAnchor.constraint(equalTo: nameTextView.leadingAnchor, constant: 9),
      detailTrailingConstraint
    ]
  }
  
  func configure(
    bird: BirdModel
  ) {
    opinionLabel.text = bird.opinion
    nameLabel.text = bird.name
    detailLabel.text = bird.detail
    
    // TODO: - BirdModel 수정
    detailGraphView.configure(
      graphInfos: bird.graphInfos,
      buying: bird.judgment
    )
    
    setupConstraints(buying: bird.judgment)
    applyParagraphStyleToDetailLabel()
    
    self.backgroundView.backgroundColor = bird.judgment ? .akColor(.akYellow) : .akColor(.akRed)
  }
  
  @objc func tappedView() {
    isExpanded.toggle()
    setupConstraints(isExpanded: isExpanded)
    animateExpansion()
  }
  
  private func setupConstraints(buying: Bool) {
    opinionLeadingConstraint?.isActive = false
    opinionLeadingConstraint?.constant = buying ? horizentalPadding : largeHorizentalPadding
    opinionLeadingConstraint?.isActive = true
  }
  
  private func setupConstraints(isExpanded: Bool) {
    backgroundBottomClosedConstraint?.isActive = false
    self.detailVetricalOpenedConstraint?.forEach { $0.isActive = false }
    backgroundBottomClosedConstraint =  backgroundView.bottomAnchor.constraint(equalTo: isExpanded ? detailGraphView.bottomAnchor : nameTextView.bottomAnchor, constant: 20)
    self.detailVetricalOpenedConstraint?.forEach { $0.isActive = isExpanded }
    backgroundBottomClosedConstraint?.isActive = true
  }
  
  private func animateExpansion() {
    UIView.animate(
      withDuration: 0.3,
      delay: 0,
      options: [.allowUserInteraction],
      animations: {
        self.detailLabel.alpha = self.isExpanded ? 1 : 0
        self.layoutIfNeeded()
      }
    )
  }

  private func applyParagraphStyleToDetailLabel() {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 10
    if let text = detailLabel.text {
      detailLabel.attributedText = NSAttributedString(
        string: text,
        attributes: [.paragraphStyle: paragraphStyle]
      )
    }
  }
  
  private func setupLayout() {
    backgroundView.layer.cornerRadius = 30
    backgroundView.layer.masksToBounds = true
  }
}

// Preview
#Preview {
  let preview = BirdReactionTextView()
  preview.configure(
    bird: ForeignBird.init(
      judgment: .init(
        userQuestion: .init(
          country: .init(
            name: "베트남",
            currency: .init(
              unitTitle: "동",
              unit: 0.0589
            )
          ),
          category: "숙소",
          amount: 5000
        ),
        standards: [
          .init(category: "숙소", name: "3성급", amount: 3000)
        ]
      )
    )
  )
  
  let tapGesture = UITapGestureRecognizer(
    target: preview.self,
    action: #selector(preview.tappedView)
  )
  preview.addGestureRecognizer(tapGesture)
  
  return preview
}
