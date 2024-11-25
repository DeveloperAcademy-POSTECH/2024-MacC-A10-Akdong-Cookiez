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
  
  let detailGraph = DetailGraphView().set()
  
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
    name: String,
    opinion: String,
    detail: String,
    buying: Bool,
    birdImageType: BirdCharacterImageType
  ) {
    textContainerView.configure(
      title: name,
      opinion: opinion,
      detail: detail,
      buying: buying
    )
    
    characterImageView.configure(
      buying: buying,
      correctImage: birdImageType.buying,
      crossImage: birdImageType.notBuying
    )
    
    setConstraintsJudgment(buying)
  }
  
  func tappedCell() {
    textContainerView.tappedView()
  }
}

#Preview {
  let birdCell = BirdReactionCell()
  
  birdCell.configure(
    name: "베트남 10년차",
    opinion: "어쩌구저쩌구",
    detail: "일반적인 베트남의 식당 가격보다\n약 40,000동 비싸요!\n하지만 캐쥬얼다이닝의 가격과 비교하면\n약 50,000동 저렴한 편이에요.",
    buying: true,
    birdImageType: .foriegn
  )

  birdCell.tappedCell()
  birdCell.widthAnchor.constraint(equalToConstant: 380).isActive = true
  birdCell.heightAnchor.constraint(equalToConstant: 200).isActive = true

  return birdCell
}
