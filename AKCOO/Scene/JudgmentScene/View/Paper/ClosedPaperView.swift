//
//  ClosedPaperView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class ClosedPaperView: UIView {
  // MARK: - Views
  let paperView = UIView().set {
    $0.backgroundColor = .white
  }
  
  let paper = UIView().set {
    $0.backgroundColor = .white
  }
  
  let upperStack = UIStackView().set {
    $0.axis = .vertical
    $0.spacing = 8
  }
  
  let countyCategoryStack = UIStackView().set {
    $0.axis = .horizontal
    $0.alignment = .fill
    $0.spacing = 6
    $0.distribution = .equalSpacing
  }
  
  let countryLabel = UILabel().set {
    $0.text = "베트남"
    $0.font = .akFont(.gmarketBold14)
    $0.textColor = .akColor(.black)
  }
  
  let category = UIView().set {
    $0.backgroundColor = .akColor(.akBlue500)
    $0.layer.cornerRadius = 12
    $0.layer.masksToBounds = true
  }
  
  let categoryLabel = UILabel().set {
    $0.text = "카테고리"
    $0.font = .akFont(.gmarketMedium12)
    $0.textColor = .akColor(.white)
  }
  
  let amountView = UIView().set {
    $0.backgroundColor = .clear
  }
  
  let amountLabel = UILabel().set {
    $0.text = "200,000"
    $0.font = .akFont(.gmarketBold14)
    $0.textColor = .black
    $0.textAlignment = .right
  }
  
  let unitTitleLabel = UILabel().set {
    $0.text = "동"
    $0.font = .akFont(.gmarketBold14)
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
    $0.font = .akFont(.gmarketMedium13)
    $0.textColor = .akColor(.akGray300)
  }
  
  let reInputTextView = UIView().set {
    $0.backgroundColor = .clear
  }
  
  let downImageView = UIImageView().set {
    $0.image = UIImage(systemName: "chevron.down")
    $0.tintColor = .akColor(.akGray300)
    $0.contentMode = .scaleAspectFit
  }
  
  let reInputLabel = UILabel().set {
    $0.text = "다시 입력하기"
    $0.textColor = .akColor(.akGray300)
    $0.font = .akFont(.gmarketMedium12)
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }
  
  func setupViews() {
    addSubview(paperView)
    addSubview(paper)
    
    paper.addSubview(upperStack)
    paper.addSubview(separatorLine)
    paper.addSubview(convertKRWLabel)
    paper.addSubview(reInputTextView)
    
    upperStack.addArrangedSubview(countyCategoryStack)
    upperStack.addArrangedSubview(amountView)
    
    amountView.addSubview(amountLabel)
    amountView.addSubview(unitTitleLabel)
    
    countyCategoryStack.addArrangedSubview(countryLabel)
    countyCategoryStack.addArrangedSubview(category)
    
    category.addSubview(categoryLabel)
    
    reInputTextView.addSubview(downImageView)
    reInputTextView.addSubview(reInputLabel)
  }
  
  func setupConstraints() {
    let horizontalPadding: CGFloat = 35
    let topPadding: CGFloat = 17
    let bottomPadding: CGFloat = 13
    let innerPadding: CGFloat = 6
    
    NSLayoutConstraint.activate([
      paperView.topAnchor.constraint(equalTo: topAnchor),
      paperView.leadingAnchor.constraint(equalTo: leadingAnchor),
      paperView.trailingAnchor.constraint(equalTo: trailingAnchor),
      paperView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      paper.topAnchor.constraint(equalTo: topAnchor),
      paper.leadingAnchor.constraint(equalTo: leadingAnchor),
      paper.trailingAnchor.constraint(equalTo: trailingAnchor),
      paper.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      upperStack.topAnchor.constraint(equalTo: paper.topAnchor, constant: topPadding),
      upperStack.leadingAnchor.constraint(equalTo: paper.leadingAnchor, constant: horizontalPadding),
      upperStack.trailingAnchor.constraint(equalTo: paper.trailingAnchor, constant: -horizontalPadding),
      
      amountView.topAnchor.constraint(equalTo: amountLabel.topAnchor),
      amountView.leadingAnchor.constraint(equalTo: separatorLine.leadingAnchor),
      amountView.trailingAnchor.constraint(equalTo: unitTitleLabel.trailingAnchor),
      amountView.bottomAnchor.constraint(equalTo: amountLabel.bottomAnchor),
      unitTitleLabel.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 4),
      
      categoryLabel.topAnchor.constraint(equalTo: category.topAnchor, constant: 5),
      categoryLabel.leadingAnchor.constraint(equalTo: category.leadingAnchor, constant: 8),
      categoryLabel.bottomAnchor.constraint(equalTo: category.bottomAnchor, constant: -5),
      categoryLabel.trailingAnchor.constraint(equalTo: category.trailingAnchor, constant: -8),
      
      separatorLine.topAnchor.constraint(equalTo: upperStack.bottomAnchor, constant: innerPadding),
      separatorLine.leadingAnchor.constraint(equalTo: paper.leadingAnchor, constant: horizontalPadding),
      separatorLine.trailingAnchor.constraint(equalTo: paper.trailingAnchor, constant: -horizontalPadding),
      separatorLine.heightAnchor.constraint(equalToConstant: 1),
      
      convertKRWLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: innerPadding),
      convertKRWLabel.trailingAnchor.constraint(equalTo: separatorLine.trailingAnchor),
      convertKRWLabel.bottomAnchor.constraint(equalTo: reInputTextView.topAnchor, constant: -7),
      
      reInputTextView.centerXAnchor.constraint(equalTo: paper.centerXAnchor),
      reInputTextView.heightAnchor.constraint(equalTo: reInputLabel.heightAnchor),
      reInputTextView.bottomAnchor.constraint(equalTo: paper.bottomAnchor, constant: -bottomPadding),
      downImageView.leadingAnchor.constraint(equalTo: reInputTextView.leadingAnchor),
      downImageView.heightAnchor.constraint(equalTo: reInputLabel.heightAnchor),
      downImageView.trailingAnchor.constraint(equalTo: reInputLabel.leadingAnchor, constant: -4),
      reInputLabel.trailingAnchor.constraint(equalTo: reInputTextView.trailingAnchor)
      
    ])
  }
  
  private func setupLayout() {
    paper.layer.cornerRadius = 30
    paper.layer.masksToBounds = true
    paperView.layer.cornerRadius = 30
    paperView.layer.masksToBounds = true
  }
  
  func configure(userQuestion: UserQuestion) {
    countryLabel.text = userQuestion.country.name
    categoryLabel.text = userQuestion.category
    
    let unitTitle = userQuestion.country.currency.unitTitle
    let unit = userQuestion.country.currency.unit
    
    let amount = String(userQuestion.amount).formatWithComma() ?? "0"
    let convertAmount = String(userQuestion.amount * unit).formatWithComma() ?? "0"
    amountLabel.text = "\(amount)"
    unitTitleLabel.text = "\(unitTitle)"
    convertKRWLabel.text = "약 \(convertAmount) 원"
  }
}

#Preview {
  let paper = ClosedPaperView()
  paper.configure(
    userQuestion: .init(
      country: .init(name: "스위스", currency: .init(unitTitle: "프랑", unit: 1575.64)),
      category: "물품",
      amount: 100000
    )
  )
  
  return paper
}
