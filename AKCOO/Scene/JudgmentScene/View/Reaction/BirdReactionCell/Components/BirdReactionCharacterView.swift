//
//  BirdReactionCharacterView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//
import UIKit

class BirdReactionCharacterView: UIView {
  // MARK: - Properties
  
  private let birdImageView = UIImageView().set {
    $0.contentMode = .scaleAspectFit
    $0.isHidden = true
  }
  
  private let markImageView = UIImageView().set {
    $0.contentMode = .scaleAspectFit
    $0.isHidden = true
  }
  
  private var correctBirdImage: UIImage?
  private var crossBirdImage: UIImage?
  private var omarkImage = UIImage(resource: .omark)
  private var xmarkImage = UIImage(resource: .xmark)
  
  private var markLeadingConstraint: NSLayoutConstraint?
  private var markTrailingConstraint: NSLayoutConstraint?
  
  // MARK: - Initializers
  
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
  
  // MARK: - Setup Methods
  
  private func setupViews() {
    addSubview(markImageView)
    addSubview(birdImageView)
  }
  
  private func setupConstraints() {
    // birdImageView 제약 조건
    NSLayoutConstraint.activate([
      birdImageView.widthAnchor.constraint(equalToConstant: 87),
      birdImageView.heightAnchor.constraint(equalToConstant: 77),
      markImageView.heightAnchor.constraint(equalToConstant: 43),
      markImageView.widthAnchor.constraint(equalToConstant: 33),
      
      birdImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      birdImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      birdImageView.topAnchor.constraint(equalTo: topAnchor),
      birdImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      markImageView.bottomAnchor.constraint(equalTo: birdImageView.bottomAnchor, constant: -50)
    ])

    markLeadingConstraint = markImageView.leadingAnchor.constraint(equalTo: birdImageView.leadingAnchor, constant: 19)
    markTrailingConstraint = markImageView.trailingAnchor.constraint(equalTo: birdImageView.trailingAnchor, constant: -19)
    
    // 초기에는 leadingConstraint 활성화
    markLeadingConstraint?.isActive = false
    markTrailingConstraint?.isActive = false
  }
  
  // MARK: - Configuration
  
  func configure(buying: Bool, correctImage: UIImage, crossImage: UIImage) {
    self.correctBirdImage = correctImage
    self.crossBirdImage = crossImage

    updateImages(buying)
  }
  
  private func updateImages(_ buying: Bool) {
    markLeadingConstraint?.isActive = false
    markTrailingConstraint?.isActive = false
    // 이미지 설정
    birdImageView.image = buying ? correctBirdImage : crossBirdImage
    markImageView.image = buying ? omarkImage : xmarkImage
    
    markImageView.isHidden = false
    birdImageView.isHidden = false
    
    markLeadingConstraint?.isActive = buying
    markTrailingConstraint?.isActive = !buying
  }
}

// Preview 화면
#Preview {
  let bird = BirdReactionCharacterView()
  // O 상태
  bird.configure(
    buying: false,
    correctImage: UIImage(resource: .greenbirdpointL),
    crossImage: UIImage(resource: .greenbirdpointR)
  )
  return bird
}
