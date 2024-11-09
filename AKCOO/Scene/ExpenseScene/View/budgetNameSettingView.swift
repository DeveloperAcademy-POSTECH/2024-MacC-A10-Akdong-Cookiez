//
//  budgetNameSettingView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class BudgetNameSettingView: UIViewController {
  
  // MARK: - UI Components
  private let nameLabel = UILabel().set {
    $0.text = "이름"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.gray3)
  }
  
  private let textField = UITextField().set {
    $0.borderStyle = .none
    $0.placeholder = "이름을 입력하세요"
    $0.font = UIFont.akFont(.gmarketLight16)
    $0.textAlignment = .right
  }
  
  private let separatorLine =  UIView().set {
    $0.backgroundColor = UIColor.akColor(.black)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK: - Setup Methods
  private func setupUI() {
    view.backgroundColor = .white
    
    view.addSubview(nameLabel)
    view.addSubview(textField)
    view.addSubview(separatorLine)
    
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
      
      textField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
      textField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
      textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      
      separatorLine.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
      separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      separatorLine.heightAnchor.constraint(equalToConstant: 0.3)
    ])
  }
}

@available(iOS 17.0, *)
#Preview {
  let vc = BudgetNameSettingView()
  return vc
}
