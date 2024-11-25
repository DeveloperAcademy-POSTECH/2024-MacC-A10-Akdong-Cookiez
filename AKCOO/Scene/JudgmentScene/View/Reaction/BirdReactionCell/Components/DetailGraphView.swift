//
//  DetailGraphView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/25/24.
//

import UIKit

class DetailGraphView: UIView {
  
  // MARK: - Views
  private let graphView = UIView().set {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 3
    $0.layer.masksToBounds = true
  }
  
  private let tickMarkView = UIView().set {
    $0.backgroundColor = UIColor.akColor(.akGray300)
  }
  
  private let averageLabel = UILabel().set {
    $0.text = "평균"
    $0.textColor = UIColor.akColor(.akGray200)
    $0.font = UIFont.akFont(.gmarketMedium13)
    $0.textAlignment = .center
  }
  
  private let arrowImageView = UIImageView().set {
    $0.image = UIImage(named: "arrow") // Replace with the actual arrow image
    $0.contentMode = .scaleAspectFit
  }
  
  // MARK: - Properties
  private var minValue: CGFloat = 0
  private var maxValue: CGFloat = 100
  private var userAmount: CGFloat = 50
  
  // MARK: - Initializer
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
  
  // MARK: - Setup
  private func setupViews() {
    addSubview(graphView)
    addSubview(tickMarkView)
    addSubview(averageLabel)
    addSubview(arrowImageView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      arrowImageView.topAnchor.constraint(equalTo: topAnchor),
      arrowImageView.bottomAnchor.constraint(equalTo: graphView.bottomAnchor),
      arrowImageView.heightAnchor.constraint(equalToConstant: 20),
      
      graphView.leadingAnchor.constraint(equalTo: leadingAnchor),
      graphView.trailingAnchor.constraint(equalTo: trailingAnchor),
      graphView.heightAnchor.constraint(equalToConstant: 6),
      
      // Tick mark constraints
      tickMarkView.centerXAnchor.constraint(equalTo: graphView.centerXAnchor),
      tickMarkView.topAnchor.constraint(equalTo: graphView.topAnchor, constant: 3),
      tickMarkView.widthAnchor.constraint(equalToConstant: 1),
      tickMarkView.heightAnchor.constraint(equalToConstant: 6),
      
      // Average label constraints
      averageLabel.topAnchor.constraint(equalTo: tickMarkView.bottomAnchor, constant: 3),
      averageLabel.centerXAnchor.constraint(equalTo: tickMarkView.centerXAnchor),
      averageLabel.bottomAnchor.constraint(equalTo: bottomAnchor )
    ])
  }
  
  // MARK: - Configure
  func configure(
    criteria: String,
    minValue: CGFloat,
    maxValue: CGFloat,
    userAmount: CGFloat
  ) {
    self.averageLabel.text = criteria
    self.minValue = minValue
    self.maxValue = maxValue
    self.userAmount = userAmount
    
    layoutArrow()
  }
  
  private func layoutArrow() {
    // Ensure userAmount is within the allowed range
    let normalizedAmount = max(min(userAmount, maxValue), minValue)
    let range = maxValue - minValue
    let percentage = (normalizedAmount - minValue) / range
    
    // Calculate arrow position
    let availableWidth = graphView.bounds.width - 16 // 8 padding on each side
    let arrowPosition = 8 + percentage * availableWidth
    
    // Update arrow constraint
//    arrowImageView.translatesAutoresizingMaskIntoConstraints = true
    arrowImageView.frame.origin.x = graphView.frame.minX + arrowPosition - arrowImageView.bounds.width / 2
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layoutArrow()
  }
}

#Preview {
  let view = DetailGraphView()
  view
    .configure(
      criteria: "이전소비", 
      minValue: 10,
      maxValue: 10000,
      userAmount: 0
    )
  return view
}