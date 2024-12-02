//
//  UserInfoTitleView.swift
//  AKCOO
//
//  Created by Anjin on 12/2/24.
//

import UIKit

class UserInfoTitleView: UIView {
  // MARK: - Views
  let typeTitleLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium30)
    $0.textColor = .akColor(.black)
    $0.numberOfLines = 0
    $0.adjustsFontForContentSizeCategory = true
    
    var paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.17
    $0.attributedText = NSMutableAttributedString(
      string: "나의 판단 유형은",
      attributes: [
        NSAttributedString.Key.paragraphStyle: paragraphStyle
      ]
    )
  }
  
  let typeContentsLabel = UILabel().set {
    $0.text = "베트남 10년차"
    $0.font = .akFont(.gmarketBold30)
    $0.textColor = .akColor(.black)
    $0.numberOfLines = 0
    $0.adjustsFontForContentSizeCategory = true
    
    var paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.17
    $0.attributedText = NSMutableAttributedString(
      string: $0.text ?? "",
      attributes: [
        NSAttributedString.Key.paragraphStyle: paragraphStyle
      ]
    )
  }
  
  let underlineView = UIView().set {
    $0.backgroundColor = .akColor(.black)
  }
  
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
    addSubview(typeTitleLabel)
    addSubview(typeContentsLabel)
    addSubview(underlineView)
  }
  
  private func setupConstraints() {
    let contentsLabelWidth = typeContentsLabel
      .sizeThatFits(CGSize(
        width: CGFloat.greatestFiniteMagnitude,
        height: CGFloat.greatestFiniteMagnitude
      )).width
    
    NSLayoutConstraint.activate([
      typeTitleLabel.topAnchor.constraint(equalTo: topAnchor),
      typeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      typeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      typeContentsLabel.topAnchor.constraint(equalTo: typeTitleLabel.bottomAnchor),
      typeContentsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      typeContentsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      underlineView.heightAnchor.constraint(equalToConstant: 1),
      underlineView.widthAnchor.constraint(equalToConstant: contentsLabelWidth),
      underlineView.topAnchor.constraint(equalTo: typeContentsLabel.bottomAnchor),
      underlineView.leadingAnchor.constraint(equalTo: leadingAnchor),
      underlineView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func configure(userJudgmentType: String) {
    typeContentsLabel.text = userJudgmentType
  }
}
