//
//  ClosedPaperView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class ClosedPaperView: UIView {
  // MARK: - Views
  let paperBackgroundView = UIView().set {
    $0.backgroundColor = .white
  }
  
  let contentStack = UIStackView().set {
    $0.axis = .horizontal
    //    $0.alignment = .fill
    //    $0.distribution = .fill
  }
  
  let titleStack = UIStackView().set {
    $0.axis = .horizontal
    $0.alignment = .leading
    $0.spacing = 6
  }
  
  let titleLabel = UILabel().set {
    $0.text = "베트남"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
  }
  
  let categoryLabel = UILabel().set {
    $0.text = "카테고리"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
  }
  
  let moneyAmountLabel = UILabel().set {
    $0.text = "200,000 동"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
    $0.textAlignment = .right
  }
  
  let separatorLine = UIView().set {
    $0.accessibilityIdentifier = "AmountMoneySeparatorLine"
    $0.frame.size.height = 1
    $0.backgroundColor = UIColor.akColor(.black)
  }
  
  let convertKRWLabel = UILabel().set {
    $0.text = "약 11,000 원"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .gray
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setLayout()
  }
  
  func setupView() {
    addSubview(paperBackgroundView)
    paperBackgroundView.addSubview(contentStack)
    paperBackgroundView.addSubview(separatorLine)
    paperBackgroundView.addSubview(convertKRWLabel)
    
    titleStack.addArrangedSubview(titleLabel)
    titleStack.addArrangedSubview(categoryLabel)
    
    contentStack.addArrangedSubview(titleStack)
    contentStack.addArrangedSubview(moneyAmountLabel)
  }
  
  func setConstraints() {
    let horizontalPadding: CGFloat = 35
    let verticalPadding: CGFloat = 26
    let innerPadding: CGFloat = 4
    
    NSLayoutConstraint.activate([
      paperBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      paperBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      paperBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      paperBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      contentStack.topAnchor.constraint(equalTo: paperBackgroundView.topAnchor, constant: verticalPadding),
      contentStack.leadingAnchor.constraint(equalTo: paperBackgroundView.leadingAnchor, constant: horizontalPadding),
      contentStack.trailingAnchor.constraint(equalTo: paperBackgroundView.trailingAnchor, constant: -horizontalPadding),
      
      separatorLine.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: innerPadding),
      separatorLine.leadingAnchor.constraint(equalTo: paperBackgroundView.leadingAnchor, constant: horizontalPadding),
      separatorLine.trailingAnchor.constraint(equalTo: paperBackgroundView.trailingAnchor, constant: -horizontalPadding),
      separatorLine.heightAnchor.constraint(equalToConstant: 1),
      
      convertKRWLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: innerPadding),
      convertKRWLabel.trailingAnchor.constraint(equalTo: separatorLine.trailingAnchor),
      paperBackgroundView.bottomAnchor.constraint(equalTo: convertKRWLabel.bottomAnchor, constant: verticalPadding)
    ])
  }
  
  private func setLayout() {
    paperBackgroundView.layer.cornerRadius = 30
    paperBackgroundView.layer.masksToBounds = true
  }
}

#Preview {
  ClosedPaperView()
}
