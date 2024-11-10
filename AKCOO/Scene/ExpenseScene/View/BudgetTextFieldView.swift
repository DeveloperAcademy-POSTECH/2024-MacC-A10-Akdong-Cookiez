//
//  BudgetTextFieldView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class BudgetTextFieldView: UIView {
  
  // MARK: - Views
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .akColor(.gray1)
    view.layer.borderWidth = 0.3
    view.layer.borderColor = UIColor.akColor(.black).cgColor
    view.layer.cornerRadius = view.bounds.height / 2
    return view
  }()
  
  private let countryLabel = UILabel().set {
    $0.text = "태국(바트)"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.gray3)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let countryRateLabel = UILabel().set {
    $0.text = "1바트 = 41원"
    $0.font = UIFont.akFont(.gmarketLight12)
    $0.textColor = UIColor.akColor(.gray3)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let koreaWonLabel = UILabel().set {
    $0.text = "약 36만4,567원"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.gray3)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let textField = UITextField().set {
    $0.placeholder = "금액을 입력하세요"
    $0.borderStyle = .none
    $0.textAlignment = .left
    $0.font = UIFont.akFont(.gmarketLight16)
    $0.keyboardType = .numberPad
    $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
    $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    $0.adjustsFontForContentSizeCategory = true
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
    addSubview(containerView)
    containerView.addSubview(textField)
    
    addSubview(countryLabel)
    addSubview(countryRateLabel)
    addSubview(koreaWonLabel)
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      // 컨테이너 뷰
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      // 텍스트 필드
      textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
      textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
      textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
      textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -17),
      
      // 국가 레이블
      countryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      countryLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -6),
      
      // 환율 레이블
      countryRateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      countryRateLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -6),
      
      // 한국(원) 레이블
      koreaWonLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
      koreaWonLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
}
