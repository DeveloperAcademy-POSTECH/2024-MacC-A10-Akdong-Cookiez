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
      string: "베트남에 왔으면,\n따라라 현지물가",
      attributes: [
        NSAttributedString.Key.paragraphStyle: paragraphStyle
      ]
    )
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
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      typeTitleLabel.topAnchor.constraint(equalTo: topAnchor),
      typeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      typeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      typeTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func configure(title: String, boldTitle: String) {
    typeTitleLabel.text = title
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.17
    let attributedString = NSMutableAttributedString(
      string: title,
      attributes: [
        NSAttributedString.Key.paragraphStyle: paragraphStyle
      ]
    )
    
    // 특정 문구의 범위 확인
    if let range = title.range(of: boldTitle) {
      let nsRange = NSRange(range, in: title)
      
      // 밑줄 속성 추가
      attributedString
        .addAttribute(
          .underlineStyle,
          value: NSUnderlineStyle.single.rawValue,
          range: nsRange
        )
      
      // 폰트 속성 추가
      attributedString
        .addAttribute(
          .font,
          value: UIFont.akFont(.gmarketBold30),
          range: nsRange
        )
    }
    
    // UILabel에 적용
    typeTitleLabel.attributedText = attributedString
  }
}
