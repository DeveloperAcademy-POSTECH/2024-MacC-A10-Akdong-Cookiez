//
//  budgetTextFieldView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class BudgetTextFieldView: UIView {
  
  // MARK: Views
  private let containerView = UIView().set {
    $0.backgroundColor = .akColor(.gray1)
    $0.layer.borderWidth = 0.3
    $0.layer.borderColor = UIColor.akColor(.black).cgColor
  }
  
  private let countryLabel = UILabel().set {
    $0.text = "태국(바트)"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.gray3)
  }
  
  private let countryRateLabel = UILabel().set {
    $0.text = "1바트 = 41원"
    $0.font = UIFont.akFont(.gmarketLight12)
    $0.textColor = UIColor.akColor(.gray3)
  }
  
  private let koreaWonLabel = UILabel().set {
    $0.text = "약 36만4,567원"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.gray3)
  }
  
  private let textField = UITextField().set {
    $0.placeholder = "금액을 입력하세요"
    $0.borderStyle = .none
    $0.textAlignment = .left
    $0.font = UIFont.akFont(.gmarketLight16)
    $0.keyboardType = .numberPad
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
    addSubview(containerView)
    containerView.addSubview(textField)
    
    addSubview(countryLabel)
    addSubview(countryRateLabel)
    addSubview(koreaWonLabel)
    
    setupConstraints()
    setupTapGesture()
  }
  
  // 탭 제스처 설정
  private func setupTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    self.addGestureRecognizer(tapGesture)
  }
  
  // 키보드 내리는 메서드
  @objc private func dismissKeyboard() {
    self.endEditing(true)
  }
  
  private func setupConstraints() {
    containerView.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    countryLabel.translatesAutoresizingMaskIntoConstraints = false
    countryRateLabel.translatesAutoresizingMaskIntoConstraints = false
    koreaWonLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      // 컨테이너 뷰
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
      containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
      
      // 텍스트 필드
      textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
      textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
      textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
      
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
    
    // 텍스트 필드의 고유 크기 설정
    textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
    textField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
  }

  // MARK: Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    
    // 높이의 절반으로 cornerRadius 설정
    containerView.layer.cornerRadius = containerView.frame.height / 2
  }
}
