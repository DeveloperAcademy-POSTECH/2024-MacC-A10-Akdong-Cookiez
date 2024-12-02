//
//  GuideView.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

class GuideView: UIView {
  
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
  
  let countrySelectorTitle = CountrySelectorTitle().set()
  
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
    self.addSubview(countrySelectorTitle)
    self.addSubview(userInfoButton)
    self.addSubview(judgmentButton)
    
    userInfoButton.addTarget(self, action: #selector(tappedUserInfoBird), for: .touchUpInside)
    
    judgmentButton.addTarget(self, action: #selector(tappedStartJudgment), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      countrySelectorTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33),
      countrySelectorTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 68),
      
      userInfoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      userInfoButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
      
      judgmentButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      judgmentButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100)
    ])
  }
  
  func configure(countries: [String], selectedCountry: String) {
    countrySelectorTitle.configure(countries: countries, selectedCountry: selectedCountry)
  }
  
  @objc func tappedUserInfoBird() {
    onActionUserInfoTapped?()
  }
  
  @objc func tappedStartJudgment() {
    onActionJudgmentTapped?()
  }
}

#Preview {
  let view = GuideView()
  view.configure(
    countries: ["베트남", "스위스"],
    selectedCountry: "스위스"
  )
  
  return view
}
