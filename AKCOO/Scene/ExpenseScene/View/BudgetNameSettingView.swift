//
//  BudgetNameSettingView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class BudgetNameSettingView: UIView {
  
  // MARK: - Views
  private let nameLabel = UILabel().set {
    $0.text = "이름"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.gray3)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let textField = UITextField().set {
    $0.borderStyle = .none
    $0.placeholder = "이름을 입력하세요"
    $0.font = UIFont.akFont(.gmarketLight16)
    $0.textAlignment = .right
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let separatorLine = UIView().set {
    $0.backgroundColor = UIColor.akColor(.black)
  }
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  // MARK: - Setup Methods
  private func setupView() {
    backgroundColor = .white
    
    addSubview(nameLabel)
    addSubview(textField)
    addSubview(separatorLine)
    
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      
      textField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
      textField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      separatorLine.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
      separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
      separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
      separatorLine.heightAnchor.constraint(equalToConstant: 0.3)
    ])
  }
}
