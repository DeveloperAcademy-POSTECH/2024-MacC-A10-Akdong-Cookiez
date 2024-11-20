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
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.akGray300)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let buttonStackView = UIStackView().set {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.alignment = .center
  }
  
  private lazy var buttons: [UIButton] = (0..<5).map { index in
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 11, bottom: 6, trailing: 11)
    
    return UIButton(configuration: configuration).set {
      
      $0.backgroundColor = UIColor.akColor(.white)
      $0.titleLabel?.font = UIFont.akFont(.gmarketMedium14)
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
  private let buttonTitles = ["교통", "관광", "식비", "쇼핑", "기타"]
  private let buttonColors: [UIColor] = [.akColor(.akBlue300), .akColor(.akYellow), .akColor(.akYellow), .akColor(.akRed), .akColor(.akRed)]
  
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
  
  // MARK: - Private Methods
  private func updateButtonCornerRadius() {
    buttons.forEach { button in
      let cornerRadius = max(13, button.bounds.height / 2)
      button.layer.cornerRadius = cornerRadius
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
      sender.backgroundColor = buttonColors[index]
      selectedButtonIndex = index
    }
  }
}

#Preview {
  CategorySettingView()
}
