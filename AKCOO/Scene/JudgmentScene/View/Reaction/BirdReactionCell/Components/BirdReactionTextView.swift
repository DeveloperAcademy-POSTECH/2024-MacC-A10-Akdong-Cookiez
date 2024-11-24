//
//  BirdReactionTextView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class BirdReactionTextView: UIView {
  private let backgroundView = UIView(frame: .zero).set {
    $0.clipsToBounds = true
  }
  
  private let titleLabel = UILabel().set {
    $0.font = .akFont(.gmarketBold16)
    $0.textAlignment = .left
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let opinionLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium13)
    $0.textColor = .black
  }
  
  private let detailLabel = UILabel().set {
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
  
  private var isExpanded = false
  private var backgroundBottomConstraint: NSLayoutConstraint?
  private var detailVetricalConstraint: [NSLayoutConstraint]?
  private var titleLeadingConstraint: NSLayoutConstraint?
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
  }
  
  private func setupViews() {
    addSubview(backgroundView)
    backgroundView.addSubview(titleLabel)
    backgroundView.addSubview(opinionLabel)
    backgroundView.addSubview(detailLabel)
  }
  
  private func setupConstraints() {
    let verticalPadding: CGFloat = 20
    
    backgroundBottomConstraint = backgroundView.bottomAnchor.constraint(equalTo: opinionLabel.bottomAnchor, constant: verticalPadding)
    titleLeadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizentalPadding)
    
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundBottomConstraint!,
      
      titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: verticalPadding),
      titleLeadingConstraint!,
      
      opinionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      opinionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      
      detailLabel.topAnchor.constraint(equalTo: opinionLabel.bottomAnchor, constant: 10)
    ])
    
    let detailTrailingConstraint = detailLabel.trailingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: backgroundView.trailingAnchor, multiplier: -verticalPadding)
    detailTrailingConstraint.priority = .defaultLow
    let detailVetricalConstraint = [
      detailLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      detailTrailingConstraint
    ]
    self.detailVetricalConstraint = detailVetricalConstraint
  }
  
  func configure(
    title: String,
    opinion: String,
    detail: String,
    buying: Bool
  ) {
    titleLabel.text = "\"\(title)\""
    opinionLabel.text = opinion
    detailLabel.text = detail
    
    setupConstraints(buying: buying)
    
    self.backgroundView.backgroundColor = buying ? .akColor(.akYellow) : .akColor(.akRed)
  }
  
  @objc func tappedView() {
    isExpanded.toggle()
    setupConstraints(isExpanded: isExpanded)
    animateExpansion()
  }
  
  private func setupConstraints(buying: Bool) {
    titleLeadingConstraint?.isActive = false
    titleLeadingConstraint?.constant = buying ? horizentalPadding : largeHorizentalPadding
    titleLeadingConstraint?.isActive = true
  }
  
  private func setupConstraints(isExpanded: Bool) {
    backgroundBottomConstraint?.isActive = false
    self.detailVetricalConstraint?.forEach { $0.isActive = false }
    backgroundBottomConstraint =  backgroundView.bottomAnchor.constraint(equalTo: isExpanded ? detailLabel.bottomAnchor : opinionLabel.bottomAnchor, constant: 26)
    self.detailVetricalConstraint?.forEach { $0.isActive = isExpanded }
    backgroundBottomConstraint?.isActive = true
  }
  
  private func animateExpansion() {
    UIView.animate(
      withDuration: 0.2,
      delay: 0,
      options: [.curveLinear],
      animations: {
        self.detailLabel.alpha = self.isExpanded ? 1 : 0
        self.layoutIfNeeded()
      },
      completion: { [weak self] _ in
        guard let self else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10 // 줄 간격을 10으로 설정 (원하는 값으로 조정)
        if let text = self.detailLabel.text {
          self.detailLabel.attributedText = NSAttributedString(string: text, attributes: [.paragraphStyle: paragraphStyle])
        }
      })
  }
  
  func calculateHeightUsingSuperview() -> CGFloat {
    guard let superviewWidth = superview?.bounds.width else { return 0 }
    let targetSize = CGSize(
      width: superviewWidth,
      height: UIView.layoutFittingCompressedSize.height
    )
    
    return systemLayoutSizeFitting(
      targetSize,
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    ).height
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
    title: "베트남 10년차",
    opinion: "\"너무 비싼데... 정말 필요해?\"",
    detail: "세부 설명이 분명 있",
    buying: false
  )
  
  let tapGesture = UITapGestureRecognizer(
    target: preview.self,
    action: #selector(preview.tappedView)
  )
  preview.addGestureRecognizer(tapGesture)
  
  return preview
}
