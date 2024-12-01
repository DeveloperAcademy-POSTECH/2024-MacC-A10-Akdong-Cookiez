//
//  ChatBubbleView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/27/24.
//

import UIKit

enum ChatBubbleViewType {
  case left
  case middle
  case right
}

class ChatBubbleView: UIView {
  let bubbleView = UIView(frame: .zero).set {
    $0.backgroundColor = .akColor(.white)
    $0.layer.cornerRadius = 10
  }
  
  let textLabel = UILabel().set {
    $0.text = "짹짹이들은 계속해서 짹짹"
    $0.font = .akFont(.gmarketMedium12)
    $0.textColor = .akColor(.black)
  }
  
  lazy var bubbleEdgeImageView = UIImageView().set {
    $0.image = type != .left ? UIImage(resource: .whiteright): UIImage(resource: .whiteleft)
    $0.contentMode = .scaleAspectFill
  }
  
  private let type: ChatBubbleViewType
  
  init(type: ChatBubbleViewType, frame: CGRect = .zero) {
    self.type = type
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  override init(frame: CGRect) {
    self.type = .left
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    self.type = .left
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
  
  private func setupViews() {
    addSubview(bubbleView)
    addSubview(bubbleEdgeImageView)
    bubbleView.addSubview(textLabel)
  }
  
  private func setupConstraints() {
    let veticalPadding: CGFloat = 10
    let horizentalPadding: CGFloat = 7
    
    NSLayoutConstraint.activate([
      bubbleView.topAnchor.constraint(equalTo: topAnchor),
      bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor),
      bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      bubbleView.topAnchor.constraint(equalTo: textLabel.topAnchor, constant: -veticalPadding),
      bubbleView.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: veticalPadding),
      bubbleView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor, constant: -horizentalPadding),
      bubbleView.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: horizentalPadding),
      
      bubbleEdgeImageView.topAnchor.constraint(equalTo: bubbleView.bottomAnchor),
      bubbleEdgeImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      bubbleEdgeImageView.widthAnchor.constraint(equalToConstant: 15),
      bubbleEdgeImageView.heightAnchor.constraint(equalToConstant: 13)
    ])
    
    setupBubbleEdgeConstraints()
  }
  
  private func setupBubbleEdgeConstraints() {
    switch type {
    case .left:
      bubbleEdgeImageView.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor, constant: 10).isActive = true
    case .middle:
      bubbleEdgeImageView.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor, constant: 8).isActive = true
    case .right:
      bubbleEdgeImageView.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor, constant: 4).isActive = true
    }
  }
  
  func configure(
    chat text: String
  ) {
    textLabel.text = text
  }
}

#Preview {
  let view = ChatBubbleView(type: .right)
  view.configure(
    chat: "직전 기록과 비교해 줄게"
  )
  view.backgroundColor = .green
  
  return view
}
