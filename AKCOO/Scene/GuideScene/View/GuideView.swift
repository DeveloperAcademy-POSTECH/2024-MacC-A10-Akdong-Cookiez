//
//  GuideView.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

class GuideView: UIView {

  let titleLabel = UILabel().set {
    $0.text = "GuideView"
  }
  
  let userInfoButton = UIButton().set {
    $0.setTitle("UserInfo로 이동", for: .normal)
    $0.tintColor = .red
    $0.backgroundColor = .blue
  }
  
  let judgmentButton = UIButton().set {
    $0.setTitle("판단화면으로 이동", for: .normal)
    $0.tintColor = .red
    $0.backgroundColor = .blue
  }
  
  var onActionUserInfoTapped: (() -> Void)? // 임시 생성
  var onActionJudgmentTapped: (() -> Void)? // 임시 생성
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
  
  private func setupViews() {
    self.addSubview(titleLabel)
    self.addSubview(userInfoButton)
    self.addSubview(judgmentButton)
    
    userInfoButton.addTarget(self, action: #selector(tappedUserInfoBird), for: .touchUpInside)
    
    judgmentButton.addTarget(self, action: #selector(tappedStartJudgment), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      
      userInfoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      userInfoButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
      
      judgmentButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      judgmentButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100)
    ])
  }
  
  @objc func tappedUserInfoBird() {
    print("UserInfoBird")
    onActionUserInfoTapped?()
  }
  
  @objc func tappedStartJudgment() {
    print("Judgment")
    onActionJudgmentTapped?()
  }
}

#Preview {
  GuideView()
}
