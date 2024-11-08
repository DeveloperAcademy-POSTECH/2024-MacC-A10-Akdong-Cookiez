//
//  budgetTextFieldView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 컨테이너 뷰 생성
    let containerView = UIView()
    containerView.backgroundColor = .akColor(.gray1)
    containerView.layer.cornerRadius = 25
    containerView.layer.borderWidth = 0.3
    containerView.layer.borderColor = UIColor.akColor(.black).cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(containerView)
    
    let padding: CGFloat = 35
    
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
    ])
    
    // 텍스트 필드 추가
    let textField = UITextField()
    textField.placeholder = "금액을 입력하세요"
    textField.borderStyle = .none
    textField.textAlignment = .left
    textField.font = UIFont.akFont(.gmarketLight16)
    textField.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(textField)
    
    NSLayoutConstraint.activate([
      textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
      textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
      textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
      textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -17)
    ])
  }
}
// Xcode 프리뷰 설정 (iOS 17 이상)
@available(iOS 17.0, *)
#Preview {
  let vc = ViewController()
  return vc
}
