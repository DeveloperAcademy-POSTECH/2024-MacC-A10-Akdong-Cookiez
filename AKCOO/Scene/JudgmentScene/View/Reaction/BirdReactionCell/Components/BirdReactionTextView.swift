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
    $0.accessibilityIdentifier = "NameTextView"
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
    $0.alpha = 0
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
  
  private let detailGraphView: DetailGraphView = DetailGraphView().set {
    $0.accessibilityIdentifier = "DetailGraphView"
    $0.alpha = 0
  }
  
  private var isExpanded = false
  private var buying = false
  private var backgroundBottomClosedConstraint: NSLayoutConstraint?
  
  private var opinionLeadingConstraint: NSLayoutConstraint?
  
  private var openedConstraint: [NSLayoutConstraint]?
  private var closedConstraint: [NSLayoutConstraint]?
  
  private let horizentalPadding: CGFloat = 35
  private let largeHorizentalPadding: CGFloat = 50
  private let bottomPadding: CGFloat = 20
  
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
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
    let graphHorizentalPadding: CGFloat = 33
    
    let opinionLeadingConstraint = opinionLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: horizentalPadding)
    let opinionTrailingConstraint = opinionLabel.trailingAnchor.constraint(lessThanOrEqualTo: backgroundView.trailingAnchor, constant: -horizentalPadding+10)
    let detailTrailingConstraint = detailLabel.trailingAnchor.constraint(lessThanOrEqualTo: backgroundView.trailingAnchor, constant: -horizentalPadding+10)
    opinionTrailingConstraint.priority = .defaultHigh // 우선순위 낮추기
    detailTrailingConstraint.priority = .defaultHigh
    
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      opinionLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
      opinionLeadingConstraint,
      opinionTrailingConstraint,
      
      nameLabel.topAnchor.constraint(equalTo: nameTextView.topAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: nameTextView.leadingAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: nameTextView.bottomAnchor),
      
      nameLabel.trailingAnchor.constraint(equalTo: downImageView.leadingAnchor, constant: -4),
      
      downImageView.trailingAnchor.constraint(equalTo: nameTextView.trailingAnchor),
      downImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
      
      nameTextView.leadingAnchor.constraint(equalTo: opinionLabel.leadingAnchor, constant: 7),
      
      nameTextView.topAnchor.constraint(equalTo: opinionLabel.bottomAnchor, constant: 8),
      
      verticalLineView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 13),
      verticalLineView.widthAnchor.constraint(equalToConstant: 2),
      verticalLineView.leadingAnchor.constraint(equalTo: nameTextView.leadingAnchor),
      verticalLineView.topAnchor.constraint(equalTo: detailLabel.topAnchor),
      verticalLineView.bottomAnchor.constraint(equalTo: detailLabel.bottomAnchor),
      
      detailLabel.leadingAnchor.constraint(equalTo: verticalLineView.leadingAnchor, constant: 8),
      detailTrailingConstraint,

      detailGraphView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: graphHorizentalPadding),
      detailGraphView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -graphHorizentalPadding) // 임시
    ])
    
    self.opinionLeadingConstraint = opinionLeadingConstraint
    opinionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    opinionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    detailLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    detailLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    
    setupConstraintsVertical()
  }
  
  private func setupConstraintsVertical() {
    let closedConstraint = [
      nameTextView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -bottomPadding)
    ]
    let openedConstraint = [
      detailGraphView.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 9),
      detailGraphView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -bottomPadding)
    ]
    
    closedConstraint.forEach { $0.isActive = true }
    
    self.closedConstraint = closedConstraint
    self.openedConstraint = openedConstraint
  }
  
  func configure(
    bird: BirdModel
  ) {
    opinionLabel.text = "\"\(bird.opinion)\""
    nameLabel.text = bird.name
    detailLabel.text = bird.detail
    
    detailGraphView.configure(
      graphInfos: bird.graphInfos,
      buying: bird.judgment
    )
    
    setupConstraints(buying: bird.judgment)
    applyParagraphStyleToDetailLabel()
    self.buying = bird.judgment
    
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
    openedConstraint?.forEach { $0.isActive = false }
    closedConstraint?.forEach { $0.isActive = false }
    openedConstraint?.forEach { $0.isActive = isExpanded }
    closedConstraint?.forEach { $0.isActive = !isExpanded }

    if !buying {
      opinionLeadingConstraint?.isActive = false
      opinionLeadingConstraint?.constant = isExpanded ? horizentalPadding : largeHorizentalPadding
      opinionLeadingConstraint?.isActive = true
    }
  }
  
  private func animateExpansion() {
    UIView.animate(
      withDuration: 0.3,
      delay: 0,
      options: [.allowUserInteraction],
      animations: {
        self.detailLabel.alpha = self.isExpanded ? 1 : 0
        self.verticalLineView.alpha = self.isExpanded ? 1 : 0
        self.detailGraphView.alpha = self.isExpanded ? 1 : 0
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
