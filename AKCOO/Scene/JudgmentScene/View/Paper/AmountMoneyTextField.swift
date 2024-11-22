//
//  AmountMoneyTextField.swift
//  AKCOO
//
//  Created by 박혜운 on 11/13/24.
//

import UIKit

class AmountMoneyTextField: UIView {
  
  // MARK: - Views
  let contentStack = UIStackView().set {
    $0.accessibilityIdentifier = "ContentStackView"
    $0.axis = .vertical
    $0.alignment = .trailing
    $0.distribution = .fill
    $0.spacing = 8
  }
  
  let inputContainer = UIStackView().set {
    $0.accessibilityIdentifier = "InputContainerView"
    $0.axis = .horizontal
    $0.alignment = .trailing
    $0.distribution = .fill
    $0.spacing = 0
  }
  
  let titleLabel = UILabel().set {
    $0.accessibilityIdentifier = "AmountMoneyTitleLabel"
    $0.text = "금액"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.black)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  let textField = UITextField().set {
    $0.accessibilityIdentifier = "AmountMoneyTextField"
    $0.borderStyle = .none
    $0.placeholder = "판단할 금액을 입력하세요"
    $0.font = UIFont.akFont(.gmarketBold16)
    $0.textAlignment = .right
    $0.adjustsFontForContentSizeCategory = true
  }
  
  let unitLabel = UILabel().set {
    $0.accessibilityIdentifier = "AmountMoneyUnitLabel"
    $0.text = "동"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.akGray300)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  let separatorLine = UIView().set {
    $0.accessibilityIdentifier = "AmountMoneySeparatorLine"
    $0.frame.size.height = 1
    $0.backgroundColor = UIColor.akColor(.black)
  }
  
  let krwLabel = UILabel().set {
    $0.accessibilityIdentifier = "AmountMoneyConvertKRWLabel"
    $0.text = "약 0원"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.akGray300)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  // MARK: - Initializers
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
    updateStackViewAxis()
  }
  
  // MARK: - Setup Methods
  private func setupView() {
    inputContainer.addArrangedSubview(textField)
    inputContainer.addArrangedSubview(unitLabel)
    
    contentStack.addArrangedSubview(titleLabel)
    contentStack.addArrangedSubview(inputContainer)
    
    addSubview(contentStack)
    addSubview(separatorLine)
    addSubview(krwLabel)
  }
  
  private func setConstraints() {
    let unitTrailingConstant: CGFloat = -15
    textField.backgroundColor = .darkGray
    titleLabel.backgroundColor = .red
    
    NSLayoutConstraint.activate([
      contentStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: unitTrailingConstant),
      
      separatorLine.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: 9),
      separatorLine.heightAnchor.constraint(equalToConstant: 1),
      separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
      separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      krwLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 5),
      krwLabel.trailingAnchor.constraint(equalTo: separatorLine.trailingAnchor, constant: unitTrailingConstant),
      krwLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      textField.trailingAnchor.constraint(equalTo: unitLabel.leadingAnchor),
      unitLabel.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor)
    ])
    
    unitLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    unitLabel.setContentHuggingPriority(.required, for: .horizontal)
    textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
  }
  
  private func updateStackViewAxis() {
    let currentContentSize = UIApplication.shared.preferredContentSizeCategory

    if currentContentSize > .large {
      contentStack.axis = .vertical
    } else {
      contentStack.axis = .horizontal
    }
  }
}

#Preview {
  let preview = AmountMoneyTextField(frame: .init(origin: .zero, size: .init(width: 380, height: 400))).set()
  let containerView = UIViewController()
  containerView.view.addSubview(preview)
  containerView.view.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
  
  NSLayoutConstraint.activate([
    preview.leadingAnchor.constraint(equalTo: containerView.view.leadingAnchor),
    preview.trailingAnchor.constraint(equalTo: containerView.view.trailingAnchor),
    preview.topAnchor.constraint(equalTo: containerView.view.topAnchor),
    preview.bottomAnchor.constraint(equalTo: containerView.view.bottomAnchor)
  ])
  
  return containerView
}
