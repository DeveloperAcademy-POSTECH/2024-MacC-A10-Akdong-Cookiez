//
//  CategorySettingView.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class CategorySelector: UIView {
  
  // MARK: - Views
  
  let contentStack = UIStackView().set {
    $0.axis = .horizontal
    $0.alignment = .center
    $0.distribution = .fill
    $0.distribution = .equalSpacing
  }
  
  lazy var titleLabel: UILabel = .paperLabel(with: "카테고리").set()
  
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
  
  // MARK: - OnAction
  var onActionChangeCategory: ((String?) -> Void)?
  
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
  
  // MARK: - LifeCycle
  override func layoutSubviews() {
    super.layoutSubviews()
    updateButtonLayout()
  }
  
  // MARK: - Setup Methods
  private func setupViews() {
    addSubview(contentStack)
    
    contentStack.addArrangedSubview(titleLabel)
    contentStack.addArrangedSubview(buttonStackView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      contentStack.topAnchor.constraint(equalTo: topAnchor),
      contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
      contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  private func updateButtonLayout() {
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
      button.akFont(.gmarketMedium14)
      button.titleLabel?.adjustsFontForContentSizeCategory = true
      
      // 상태에 따라 버튼의 색상을 업데이트
      button.configurationUpdateHandler = { [weak self] button in
        guard let self else { return }
        if button.isSelected {
          button.configuration?.background.backgroundColor = self.selectedButtonColor
          button.configuration?.baseForegroundColor = .white
          self.onActionChangeCategory?(button.titleLabel?.text)
        } else {
          button.configuration?.background.backgroundColor = self.defaultButtonColor
          button.configuration?.baseForegroundColor = .black
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
  let categorySelector = CategorySelector()
  categorySelector.configure(
    categoryList: ["호텔", "숙박", "카페"],
    selected: "숙박"
  )
  return categorySelector
}
