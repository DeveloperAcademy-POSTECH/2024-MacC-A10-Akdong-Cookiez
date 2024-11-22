//
//  CategorySettingView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class CategorySelectorView: UIView {
  
  // MARK: - Views
  private let buttonStackView = UIStackView().set {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
    $0.alignment = .center
    $0.spacing = 10
  }
  
  private var buttons: [UIButton] = []
  
  // MARK: - Properties
  private var categories: [String] = ["호텔", "숙박", "카페"]
  private var selectedCategoryIndex: Int = 0
  
  private let selectedButtonColor: UIColor = .akColor(.akBlue500)
  private let defaultButtonColor: UIColor = .akColor(.akGray100)
  
  // MARK: - Initializers
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
  
  // MARK: - LifeCycle
  override func layoutSubviews() {
    super.layoutSubviews()
    updateButtonCornerRadius()
  }
  
  // MARK: - Setup Methods
  private func setupView() {
    addSubview(buttonStackView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      buttonStackView.topAnchor.constraint(equalTo: topAnchor),
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
  
  // MARK: - Public Methods
  func configure(
    categoryList: [String],
    selected selectedCategory: String = ""
  ) {
    self.categories = categoryList
    
    // 이전 버튼들 제거 및 새로운 버튼들 생성
    buttons.forEach { button in
      buttonStackView.removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    
    buttons = categories.map { title in
      var configuration = UIButton.Configuration.filled()
      configuration.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 12, bottom: 7, trailing: 12)
      
      let button = UIButton(configuration: configuration)
      button.backgroundColor = defaultButtonColor
      button.titleLabel?.font = .akFont(.gmarketMedium14)
      button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
      
      button.layer.masksToBounds = true
      button.layer.cornerCurve = .continuous
      
      button.setTitle(title, for: .normal)
      button.setTitleColor(.black, for: .normal)
      button.titleLabel?.adjustsFontForContentSizeCategory = true
      
      // 상태에 따라 버튼의 색상을 업데이트
      button.configurationUpdateHandler = { [weak self] button in
        guard let self = self else { return }
        if button.isSelected {
          button.configuration?.background.backgroundColor = self.selectedButtonColor
        } else {
          button.configuration?.background.backgroundColor = self.defaultButtonColor
        }
      }
      
      button.addTarget(
        self,
        action: #selector(buttonTapped(_:)),
        for: .touchUpInside
      )
      return button
    }
    
    buttons.enumerated().forEach { index, button in
      button.tag = index
      buttonStackView.addArrangedSubview(button)
    }
    
    // 선택된 카테고리가 있을 경우 선택, 없을 경우 첫 번째를 선택
    if let selectedIndex = categories.firstIndex(of: selectedCategory), selectedCategory != "" {
      setSelectedButton(at: selectedIndex)
    } else {
      setSelectedButton(at: 0)
    }
  }
  
  // MARK: - Private Methods
  private func setSelectedButton(at index: Int) {
    guard !buttons.isEmpty else { return }
    
    // 모든 버튼의 선택 상태를 초기화
    buttons.forEach { button in
      button.isSelected = false
    }
    
    // 새로 선택된 버튼의 선택 상태 설정
    let selectedButton = buttons[index]
    selectedButton.isSelected = true
    
    // 선택된 버튼 인덱스 업데이트
    selectedCategoryIndex = index
    layoutIfNeeded()
  }
  
  // MARK: - Actions
  @objc private func buttonTapped(_ sender: UIButton) {
    let index = sender.tag
    
    if selectedCategoryIndex != index {
      setSelectedButton(at: index)
    }
  }
}

#Preview {
  let categorySelector = CategorySelectorView()
  categorySelector.configure(
    categoryList: ["호텔", "숙박", "카페"],
    selected: "숙박"
  )
  return categorySelector
}
