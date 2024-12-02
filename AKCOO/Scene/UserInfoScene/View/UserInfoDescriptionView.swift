//
//  UserInfoDescriptionView.swift
//  AKCOO
//
//  Created by Anjin on 12/2/24.
//

import UIKit

class UserInfoDescriptionView: UIView {
  
  let whiteBackgroundView = UIView().set {
    $0.backgroundColor = .akColor(.white)
    $0.layer.cornerRadius = 30
  }
  
  let titleLabel = UILabel().set {
    $0.text = "나는 스위스 10년차와 비슷해요"
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = .akColor(.black)
  }
  
  let descriptionLabel = UILabel().set {
    $0.text = ""
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = .akColor(.black)
    $0.numberOfLines = 0
    $0.adjustsFontForContentSizeCategory = true
    
    var paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.43
    $0.attributedText = NSMutableAttributedString(
      string: $0.text ?? "",
      attributes: [
        NSAttributedString.Key.paragraphStyle: paragraphStyle
      ]
    )
  }
  
  let dividerView = UIView().set {
    $0.backgroundColor = .akColor(.black)
    $0.layer.cornerRadius = 1
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
    addSubview(whiteBackgroundView)
    addSubview(titleLabel)
    addSubview(dividerView)
    addSubview(descriptionLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      whiteBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      whiteBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      whiteBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      whiteBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 34),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -34),
      
      dividerView.widthAnchor.constraint(equalToConstant: 2),
      dividerView.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 6),
      dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 34),
      dividerView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
      
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      descriptionLabel.leadingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: 6),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
      descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    ])
  }
  
  func configure(title: String, description: String) {
    applyBoldAttributedTextToDescriptionLabel(title)
    applyDescriptionText(description)
  }
  
  private func applyBoldAttributedTextToDescriptionLabel(_ title: String) {
    let text = title
    
    // 1. 기본 스타일 설정
    let attributedString = NSMutableAttributedString(
      string: text,
      attributes: [
        .font: UIFont.akFont(.gmarketMedium14),
        .foregroundColor: UIColor.akColor(.black)
      ]
    )
    
    // 2. Bold 스타일 적용
    let boldPatterns = ["\\s*.+짹짹이", "지출 판단을 시작하세요"]
    let boldRegexes = boldPatterns.map { try? NSRegularExpression(pattern: $0) }
    
    boldRegexes.forEach { regex in
      regex?.enumerateMatches(
        in: text,
        options: [],
        range: NSRange(location: 0, length: text.utf16.count)
      ) { match, _, _ in
        if let matchRange = match?.range {
          let extendedRange = NSRange(
            location: matchRange.location,
            length: min(matchRange.length, text.utf16.count - matchRange.location)
          )
          
          if extendedRange.upperBound <= text.utf16.count {
            attributedString
              .addAttribute(
                .font,
                value: UIFont.akFont(.gmarketBold14),
                range: extendedRange
              )
          }
        }
      }
    }
    
    // 3. UILabel에 적용
    titleLabel.attributedText = attributedString
  }
  
  private func applyDescriptionText(_ text: String) {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.43
    
    let attributedString = NSMutableAttributedString(
      string: text,
      attributes: [
        NSAttributedString.Key.paragraphStyle: paragraphStyle
      ]
    )
    
    descriptionLabel.attributedText = attributedString
  }
}
