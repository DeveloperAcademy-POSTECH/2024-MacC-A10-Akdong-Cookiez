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
  
  // MARK: - Views
  private let containerView = UIView().set()
  private let textContainerView: BirdReactionTextView = BirdReactionTextView().set()
  private let characterImageView: BirdReactionCharacterView = BirdReactionCharacterView().set()
  
  // MARK: - Properties
  private var characterLeadingConstraint: NSLayoutConstraint?
  private var characterTrailingConstraint: NSLayoutConstraint?
  private var textLeadingConstraint: NSLayoutConstraint?
  private var textTrailingConstraint: NSLayoutConstraint?
  
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
    containerView.addSubview(textContainerView)
    containerView.addSubview(characterImageView)
    
    setupShadow()
  }

  private func setupConstraints() {
    characterLeadingConstraint = characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
    characterTrailingConstraint = characterImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
    textLeadingConstraint = textContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
    textTrailingConstraint = textContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)

    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      textContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
      textContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

      characterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
    
    setConstraintsJudgment()
  }
  
  private func setConstraintsJudgment(_ buying: Bool = true) {
    characterLeadingConstraint?.isActive = false
    characterTrailingConstraint?.isActive = false
    textLeadingConstraint?.isActive = false
    textTrailingConstraint?.isActive = false
    
    if buying {
      characterTrailingConstraint?.isActive = true
      textLeadingConstraint?.constant = 0
      textLeadingConstraint?.isActive = true
      textTrailingConstraint?.constant = -36
      textTrailingConstraint?.isActive = true
    } else {
      characterLeadingConstraint?.isActive = true
      textLeadingConstraint?.constant = 36
      textLeadingConstraint?.isActive = true
      textTrailingConstraint?.constant = 0
      textTrailingConstraint?.isActive = true
    }
  }
  
  private func setupShadow() {
    contentView.layer.shadowColor = UIColor.akColor(.akBlue600).cgColor
    contentView.layer.shadowOpacity = 0.9
    contentView.layer.shadowOffset = CGSize(width: 5, height: 10)
    contentView.layer.shadowRadius = 4
  }
  
  func configure(
    bird: BirdModel,
    userAmount: Double,
    birdImageType: BirdCharacterImageType
  ) {
    textContainerView.configure(
      bird: bird
    )
    
    characterImageView.configure(
      buying: bird.judgment,
      correctImage: birdImageType.buying,
      crossImage: birdImageType.notBuying
    )

    setConstraintsJudgment(bird.judgment)
  }
  
  func tappedCell() {
    textContainerView.tappedView()
  }
}

#Preview {
  let birdCell = BirdReactionCell()

  birdCell.configure(
    bird: ForeignBird.init(
      judgment: .init(
        userQuestion: .init(
          country: .init(
            name: "베트남",
            currency: .init(
              unitTitle: "동",
              unit: 0.0589
            )
          ),
          category: "숙소", 
          amount: 5000
        ),
        standards: [
          .init(category: "숙소", name: "3성급", amount: 3000)
        ]
      )
    ),
    userAmount: 5000,
    birdImageType: .foriegn
  )

  birdCell.tappedCell()
  birdCell.widthAnchor.constraint(equalToConstant: 380).isActive = true
  birdCell.heightAnchor.constraint(equalToConstant: 200).isActive = true
  birdCell.layoutIfNeeded()

  return birdCell
}
