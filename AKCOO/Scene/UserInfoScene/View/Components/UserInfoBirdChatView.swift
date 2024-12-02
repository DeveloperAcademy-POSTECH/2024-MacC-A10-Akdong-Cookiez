//
//  UserInfoBirdChatView.swift
//  AKCOO
//
//  Created by Anjin on 12/2/24.
//

import UIKit

enum UserInfoBirdChatLocation { case left, rightTop, rightBottom }

class UserInfoBirdChatView: UIView {
  let chatLocation: UserInfoBirdChatLocation
  
  let blueBackgroundView = UIView().set {
    $0.backgroundColor = .akColor(.akBlue400)
    $0.layer.cornerRadius = 10
  }
  
  let chatLabel = UILabel().set {
    $0.text = "비싸도 사요"
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = .akColor(.white)
    $0.numberOfLines = 0
    // Dynamic Type 제한
    $0.adjustsFontForContentSizeCategory = false
  }
  
  let tailImageView = UIImageView().set {
    $0.image = UIImage(resource: .blueTail)
    $0.contentMode = .scaleAspectFit
  }
  
  init(location: UserInfoBirdChatLocation, frame: CGRect = .zero) {
    self.chatLocation = location
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  override init(frame: CGRect) {
    self.chatLocation = .left
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    self.chatLocation = .left
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
  
  private func setupViews() {
    addSubview(tailImageView)
    addSubview(blueBackgroundView)
    addSubview(chatLabel)
  }
  
  private func setupConstraints() {
    let vertical: CGFloat = chatLocation == .rightBottom ? 5 : 10
    let horizontal: CGFloat = 18
    let tailLeadingSpacing: CGFloat = chatLocation == .left ? 0 : 12
    let tailTrailingSpacing: CGFloat = chatLocation == .left ? -12 : 0
    
    NSLayoutConstraint.activate([
      blueBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      blueBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      blueBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: tailLeadingSpacing),
      blueBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: tailTrailingSpacing),
      
      chatLabel.topAnchor.constraint(equalTo: blueBackgroundView.topAnchor, constant: vertical),
      chatLabel.bottomAnchor.constraint(equalTo: blueBackgroundView.bottomAnchor, constant: -vertical),
      chatLabel.leadingAnchor.constraint(equalTo: blueBackgroundView.leadingAnchor, constant: horizontal),
      chatLabel.trailingAnchor.constraint(equalTo: blueBackgroundView.trailingAnchor, constant: -horizontal),
      
      tailImageView.heightAnchor.constraint(equalToConstant: 16),
      tailImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    if chatLocation == .left {
      NSLayoutConstraint.activate([
        tailImageView.leadingAnchor.constraint(equalTo: blueBackgroundView.trailingAnchor, constant: -18),
        tailImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
      ])
    }
  }
  
  func configure(chat: String) {
    chatLabel.text = chat
    if chatLocation == .rightBottom {
      chatLabel.font = .akFont(.gmarketMedium24)
    }
  }
}
