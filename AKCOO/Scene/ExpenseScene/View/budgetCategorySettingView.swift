//
//  budgetCategorySettingView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class BudgetCategorySettingView: UIView {
  let buttonTitles = ["교통", "관광", "식비", "쇼핑", "기타"]
  
  // MARK: Views
  
  private let categoryLabel = UILabel().set {
    $0.text = "카테고리"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.adjustsFontForContentSizeCategory = true
    $0.textColor = UIColor.akColor(.gray3)
  }
  
  private let buttonStackView = UIStackView().set {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.alignment = .center
  }
  
  private let separatorLine =  UIView().set {
    $0.backgroundColor = UIColor.akColor(.black)
  }
  
  private let buttonColors: [UIColor] = [.akColor(.akBlue), .akColor(.akGreen), .akColor(.akYellow), .akColor(.akRed), .akColor(.akPurple)]
  
  private var selectedButtonIndex: Int? = nil
  
  private lazy var buttons: [UIButton] = (0..<5).map { index in
    UIButton().set {
      $0.backgroundColor = UIColor.akColor(.gray1)
      $0.titleLabel?.font = UIFont.akFont(.gmarketMedium14)
      $0.titleLabel?.adjustsFontForContentSizeCategory = true
      $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
      $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 11, bottom: 6, right: 11)
      
      $0.layer.masksToBounds = true
      $0.layer.cornerCurve = .continuous
      
      $0.setTitle(buttonTitles[index], for: .normal)
      $0.setTitleColor(.black, for: .normal)
      $0.tag = index
      $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
  }
  
  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  // MARK: Setup
  private func setupView() {
    backgroundColor = .white
    
    addSubview(separatorLine)
    addSubview(categoryLabel)
    addSubview(buttonStackView)
    
    buttons.forEach { buttonStackView.addArrangedSubview($0) }
    
    categoryLabel.translatesAutoresizingMaskIntoConstraints = false
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    separatorLine.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      
      buttonStackView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
      buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      separatorLine.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 13),
      separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
      separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
      separatorLine.heightAnchor.constraint(equalToConstant: 0.3)
    ])
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    buttons.forEach { button in
      let cornerRadius = max(13, button.bounds.height / 2)
      button.layer.cornerRadius = cornerRadius
    }
  }
  
  // MARK: Actions
  @objc private func buttonTapped(_ sender: UIButton) {
    let index = sender.tag
    
    if selectedButtonIndex == index {
      sender.backgroundColor = UIColor.akColor(.gray1)
      selectedButtonIndex = nil
    } else {
      if let previousIndex = selectedButtonIndex {
        buttons[previousIndex].backgroundColor = UIColor.akColor(.gray1)
      }
      sender.backgroundColor = buttonColors[index]
      selectedButtonIndex = index
    }
  }
}
