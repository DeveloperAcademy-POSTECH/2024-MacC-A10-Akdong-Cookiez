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
    let containerView: UIView = {
      let view = UIView()
      view.backgroundColor = .akColor(.gray1)
      view.layer.cornerRadius = 25
      view.layer.borderWidth = 0.3
      view.layer.borderColor = UIColor.akColor(.black).cgColor
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    view.addSubview(containerView)
    
    let leftLabel: UILabel = {
      let label = UILabel()
      label.text = "태국(바트)"
      label.font = UIFont.akFont(.gmarketMedium16)
      label.textColor = UIColor.akColor(.gray3)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    view.addSubview(leftLabel)
    
    let rightLabel: UILabel = {
      let label = UILabel()
      label.text = "1바트 = 41원"
      label.font = UIFont.akFont(.gmarketLight12)
      label.textColor = UIColor.akColor(.gray3)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    view.addSubview(rightLabel)
    
    let bottomLabel: UILabel = {
      let label = UILabel()
      label.text = "약 36만4,567원"
      label.font = UIFont.akFont(.gmarketMedium16)
      label.textColor = UIColor.akColor(.gray3)
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()
    view.addSubview(bottomLabel)
    
    let textField: UITextField = {
      let field = UITextField()
      field.placeholder = "금액을 입력하세요"
      field.borderStyle = .none
      field.textAlignment = .left
      field.font = UIFont.akFont(.gmarketLight16)
      field.translatesAutoresizingMaskIntoConstraints = false
      return field
    }()
    containerView.addSubview(textField)
    
    // Auto Layout 제약 조건 설정
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
      
      textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
      textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
      textField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
      textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -17),
      
      leftLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      leftLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -6),
      
      rightLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      rightLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -6),
      
      bottomLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
      bottomLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
    ])
  }
}

// Xcode 프리뷰 설정
@available(iOS 17.0, *)
#Preview {
  let vc = ViewController()
  return vc
}
