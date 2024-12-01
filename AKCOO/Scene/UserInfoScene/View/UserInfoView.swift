//
//  UserInfoView.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import UIKit

class UserInfoView: UIView {
  
  let grayBackgroundView = UIView().set {
    $0.backgroundColor = .akColor(.akGray100)
  }
  
  let titleView = UserInfoTitleView().set {
    $0.backgroundColor = .clear
  }
  
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
    addSubview(grayBackgroundView)
    addSubview(titleView)
  }
  
  private func setupConstraints() {
    let titlePadding: CGFloat = 33
    
    NSLayoutConstraint.activate([
      grayBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      grayBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      grayBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      grayBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
      titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titlePadding),
      titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -titlePadding)
    ])
  }
  
  func configure(userRecords: [UserRecord]) {
    titleView
      .configure(
        userJudgmentType: "스위스 10년차"
      )
  }
}

#Preview {
  UserInfoViewController(userInfoUseCase: UserInfoUseCaseMock())
}
