//
//  UserInfoBirdView.swift
//  AKCOO
//
//  Created by Anjin on 12/2/24.
//

import UIKit

class UserInfoBirdView: UIView {
  
  let imageView = UIImageView().set {
    $0.image = BirdCharacterImageType.foriegn.standing
    $0.contentMode = .scaleAspectFill
  }
  
  let leftChatView = UserInfoBirdChatView(
    location: .left
  ).set {
    $0.backgroundColor = .clear
  }
  
  let rightTopChatView = UserInfoBirdChatView(
    location: .rightTop
  ).set {
    $0.backgroundColor = .clear
  }
  
  let rightBottomChatView = UserInfoBirdChatView(
    location: .rightBottom
  ).set {
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
    addSubview(leftChatView)
    addSubview(rightTopChatView)
    addSubview(rightBottomChatView)
    addSubview(imageView)
  }
  
  private func setupConstraints() {
    let birdWidth: CGFloat = 166
    let birdHeight: CGFloat = 176
    
    NSLayoutConstraint.activate([
      leftChatView.topAnchor.constraint(equalTo: topAnchor),
      leftChatView.leadingAnchor.constraint(equalTo: leadingAnchor),
      
      rightTopChatView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
      rightTopChatView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      rightBottomChatView.topAnchor.constraint(equalTo: rightTopChatView.bottomAnchor, constant: 8),
      rightBottomChatView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
      
      imageView.widthAnchor.constraint(equalToConstant: birdWidth),
      imageView.heightAnchor.constraint(equalToConstant: birdHeight),
      imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
      imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func configure(
    birdType: UserJudgmentType,
    leftChat: String,
    rightTopChat: String,
    rightBottomChat: String
  ) {
    applyBirdImageView(for: birdType)
    
    leftChatView
      .configure(
        chat: leftChat
      )
    
    rightTopChatView
      .configure(
        chat: rightTopChat
      )
    
    rightBottomChatView
      .configure(
        chat: rightBottomChat
      )
  }
  
  private func applyBirdImageView(for type: UserJudgmentType) {
    switch type {
    case .foreign:
      imageView.image = BirdCharacterImageType.foriegn.standing
    case .local:
      imageView.image = BirdCharacterImageType.local.standing
    case .previous:
      imageView.image = BirdCharacterImageType.previous.standing
    case .empty:
      imageView.image = UIImage(resource: .emptyRecordBird)
      // FIXME: 레이아웃 경고 뜨는거 처리하기!!
      imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
  }
}
