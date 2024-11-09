//
//  budgetTextFieldView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class BudgetTextfieldView: UIViewController {
  
  // MARK: - UI Components
  private let containerView = UIView().set {
    $0.backgroundColor = .akColor(.gray1)
    $0.layer.borderWidth = 0.3
    $0.layer.borderColor = UIColor.akColor(.black).cgColor
  }
  
  private let leftLabel = UILabel().set {
    $0.text = "태국(바트)"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.gray3)
  }
  
  private let rightLabel = UILabel().set {
    $0.text = "1바트 = 41원"
    $0.font = UIFont.akFont(.gmarketLight12)
    $0.textColor = UIColor.akColor(.gray3)
  }
  
  private let bottomLabel = UILabel().set {
    $0.text = "약 36만4,567원"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.gray3)
  }
  
  private let textField = UITextField().set {
    $0.placeholder = "금액을 입력하세요"
    $0.borderStyle = .none
    $0.textAlignment = .left
    $0.font = UIFont.akFont(.gmarketLight16)
  }
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
  }
  
  // MARK: - Setup Methods
  private func setupView() {
    view.addSubview(containerView)
    containerView.addSubview(textField)
    
    view.addSubview(leftLabel)
    view.addSubview(rightLabel)
    view.addSubview(bottomLabel)
  }
  
  private func setupConstraints() {
    
    // Auto Layout
    NSLayoutConstraint.activate([
      // 컨테이너 뷰
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
      
      // 텍스트 필드
      textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
      textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
      textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
      textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -17),
      
      // 국가 레이블
      leftLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      leftLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -6),
      
      // 환율 레이블
      rightLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      rightLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -6),
      
      // 한국(원) 레이블
      bottomLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
      bottomLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
    ])
  }
  // MARK: - Layout Updates for Dynamic Corner Radius
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // 높이의 절반으로 cornerRadius 설정
    containerView.layer.cornerRadius = containerView.frame.height / 2
  }
}

// Xcode 프리뷰 설정
@available(iOS 17.0, *)
#Preview {
  let vc = BudgetTextfieldView()
  return vc
}
