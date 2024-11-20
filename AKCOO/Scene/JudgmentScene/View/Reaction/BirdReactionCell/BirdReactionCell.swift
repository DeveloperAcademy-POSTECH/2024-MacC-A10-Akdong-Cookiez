//
//  BirdReactionCell.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import UIKit

// MARK: - BirdReactionCell
class BirdReactionCell: UICollectionViewCell {
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
  
  func configure(with birdReactionTextView: BirdReactionTextView) {
    containerView.subviews.forEach { $0.removeFromSuperview() }
    containerView.addSubview(birdReactionTextView)
    NSLayoutConstraint.activate([
      birdReactionTextView.topAnchor.constraint(equalTo: containerView.topAnchor),
      birdReactionTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      birdReactionTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      birdReactionTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
  }
}
