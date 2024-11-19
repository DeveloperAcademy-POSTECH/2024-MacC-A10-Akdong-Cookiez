//
//  ReactionBirdCell.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import UIKit

// MARK: - ReactionBirdCell
class ReactionBirdCell: UICollectionViewCell {
  static let identifier = "ReactionResultsCell"
  
  private let containerView = UIView().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
    setupConstraints()
  }
  
  private func setupView() {
    contentView.addSubview(containerView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  func configure(with reactionBirdTextView: ReactionBirdTextView) {
    containerView.subviews.forEach { $0.removeFromSuperview() }
    containerView.addSubview(reactionBirdTextView)
    NSLayoutConstraint.activate([
      reactionBirdTextView.topAnchor.constraint(equalTo: containerView.topAnchor),
      reactionBirdTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      reactionBirdTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      reactionBirdTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
  }
}
