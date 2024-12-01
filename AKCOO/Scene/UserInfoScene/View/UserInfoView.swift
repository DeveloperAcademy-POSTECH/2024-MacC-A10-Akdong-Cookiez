//
//  UserInfoView.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import UIKit

class UserInfoView: UIView {

  let titleLabel = UILabel().set {
    $0.text = "UserInfoView"
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
    self.addSubview(titleLabel)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}

#Preview {
  UserInfoView()
}
