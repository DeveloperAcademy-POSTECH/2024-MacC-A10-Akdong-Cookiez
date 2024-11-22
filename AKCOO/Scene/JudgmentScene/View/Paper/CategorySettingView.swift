//
//  CategorySettingView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class CategorySettingView: UIView {
  
  // MARK: - Views
  private let categoryLabel = UILabel().set {
    $0.text = "카테고리"
    $0.font = UIFont.akFont(.gmarketMedium14)
    $0.textColor = UIColor.akColor(.black)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let buttonStackView = UIStackView().set {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.alignment = .center
    $0.spacing = 10
  }
  
  private lazy var buttons: [UIButton] = (0..<3).map { index in
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 12, bottom: 7, trailing: 12)
    
    return UIButton(configuration: configuration).set {
      
      $0.backgroundColor = .akColor(.akGray200)
      $0.titleLabel?.font = .akFont(.gmarketMedium14)
      $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
      
      $0.layer.masksToBounds = true
      $0.layer.cornerCurve = .continuous
      
      $0.setTitle(buttonTitles[index], for: .normal)
      $0.setTitleColor(.black, for: .normal)
      $0.tag = index
      $0.titleLabel?.adjustsFontForContentSizeCategory = true
    }
  }
  // MARK: - Properties
  private let buttonTitles = ["호텔", "숙박", "카페"]
  private let buttonColor: UIColor = .akColor(.akBlue500)
  
  private var selectedButtonIndex: Int?
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  // MARK: - LifeCycle
  override func layoutSubviews() {
    super.layoutSubviews()
    updateButtonCornerRadius()
  }
  
  // MARK: - Setup Methods
  private func setupView() {
    backgroundColor = .white
    
    addSubview(categoryLabel)
    addSubview(buttonStackView)
    
    buttons.forEach { button in
      buttonStackView.addArrangedSubview(button)
      button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      categoryLabel.topAnchor.constraint(equalTo: topAnchor),
      categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      
      buttonStackView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
      buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  private func updateButtonCornerRadius() {
    buttons.forEach { button in
      button.layer.cornerRadius = 15
      button.clipsToBounds = true
    }
  }
  
  @objc private func buttonTapped(_ sender: UIButton) {
    let index = sender.tag
    
    if selectedButtonIndex == index {
      sender.backgroundColor = UIColor.akColor(.akGray100)
      selectedButtonIndex = nil
    } else {
      if let previousIndex = selectedButtonIndex {
        buttons[previousIndex].backgroundColor = UIColor.akColor(.akGray100)
      }
      sender.backgroundColor = buttonColor
      selectedButtonIndex = index
    }
  }
}

#Preview {
  CategorySettingView()
}
