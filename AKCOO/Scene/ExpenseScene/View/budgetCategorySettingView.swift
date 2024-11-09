//
//  budgetCategorySettingView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class BudgetCategorySettingView: UIViewController {
  
  // MARK: - UI Components
  
  private let categoryLabel = UILabel().set {
    $0.text = "카테고리"
    $0.font = UIFont.akFont(.gmarketMedium16)
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
  
  private var selectedButtons: [Bool] = Array(repeating: false, count: 5)
  
  private lazy var buttons: [UIButton] = (0..<5).map { index in
    UIButton().set {
      $0.backgroundColor = UIColor.akColor(.gray1)
      $0.titleLabel?.font = UIFont.akFont(.gmarketMedium14)
      $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
      
      $0.heightAnchor.constraint(equalToConstant: 26).isActive = true
      $0.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
      
      $0.layer.masksToBounds = true
      $0.layer.cornerCurve = .continuous
      $0.layer.cornerRadius = 13
      
      let buttonTitles = ["교통", "관광", "식비", "쇼핑", "기타"]
      $0.setTitle(buttonTitles[index], for: .normal)
      $0.setTitleColor(.black, for: .normal)
      
      $0.tag = index
      $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    // 초기 상태 설정
    for (index, button) in buttons.enumerated() {
      button.isSelected = selectedButtons[index]
      button.backgroundColor = selectedButtons[index] ? buttonColors[index] : UIColor.akColor(.gray1)
    }
  }
  
  // MARK: - Setup Methods
  private func setupUI() {
    view.backgroundColor = .white
    
    view.addSubview(separatorLine)
    view.addSubview(categoryLabel)
    view.addSubview(buttonStackView)
    
    buttons.forEach { buttonStackView.addArrangedSubview($0) }
    
    NSLayoutConstraint.activate([
      categoryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
      
      buttonStackView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
      buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 54),
      buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -53),
      
      separatorLine.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 13),
      separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      separatorLine.heightAnchor.constraint(equalToConstant: 0.3)
    ])
  }
  
  // 레이아웃 변경 시 버튼의 코너 반경을 업데이트하는 메서드
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    buttons.forEach { $0.layer.cornerRadius = $0.bounds.height / 2 }
  }
  
  @objc private func buttonTapped(_ sender: UIButton) {
    let index = sender.tag
    selectedButtons[index].toggle()
    
    sender.isSelected = selectedButtons[index]
    
    if selectedButtons[index] {
      sender.backgroundColor = buttonColors[index]
    } else {
      sender.backgroundColor = UIColor.akColor(.gray1)
    }
  }
}

@available(iOS 17.0, *)
#Preview {
  let vc = BudgetCategorySettingView()
  return vc
}
