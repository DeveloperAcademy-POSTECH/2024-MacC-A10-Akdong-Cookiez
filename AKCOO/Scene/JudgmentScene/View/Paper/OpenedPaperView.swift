//
//  OpenedPaperView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

enum OpenedPaperType {
  case ready
  case edit
}

class OpenedPaperView: UIView {
  let paperStackView = UIStackView().set {
    $0.axis = .vertical
    $0.alignment = .fill
    $0.distribution = .fill
    $0.spacing = 23
  }
  
  let paperView = UIView(frame: .zero).set {
    $0.backgroundColor = .akColor(.white)
    $0.layer.cornerRadius = 20
  }
  
  let countrySelector = CountrySelector().set()
  let categorySelector = CategorySelector().set()
  let amountTextField = AmountMoneyTextField().set()
  
  let readyButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 22, leading: 0, bottom: 22, trailing: 0)
    let button = UIButton(configuration: configuration)
    return button.set {
      $0.setTitle("지출 판단하기", for: .normal)
      $0.configuration?.baseForegroundColor = .black
      $0.akFont(.gmarketBold16)
      $0.configuration?.background.backgroundColor = .akColor(.akGray200)
      $0.layer.cornerRadius = 20
      $0.isEnabled = false
    }
  }()
  
  lazy var greenBirdImageView = UIImageView().set {
    $0.image = BirdCharacterImageType.foriegn.basic
    $0.contentMode = .scaleAspectFit
    $0.isHidden = type == .edit
  }
  
  lazy var redBirdImageView = UIImageView().set {
    $0.image = BirdCharacterImageType.local.basic
    $0.contentMode = .scaleAspectFit
    $0.isHidden = type == .edit
  }
  
  lazy var yellowBirdImageView = UIImageView().set {
    $0.image = BirdCharacterImageType.previous.basic
    $0.contentMode = .scaleAspectFit
    $0.isHidden = type == .edit
  }
  
  var greenBirdChatBubbleView = ChatBubbleView(type: .left, frame: .zero).set {
    $0.alpha = 0
  }
  var redBirdChatBubbleView = ChatBubbleView(type: .middle, frame: .zero).set {
    $0.alpha = 0
  }
  var yellowBirdChatBubbleView = ChatBubbleView(type: .right, frame: .zero).set {
    $0.alpha = 0
  }
  
  private var countryName: String?
  private var selectedCategory: String?
  private var previousRecordExists: Bool = true
  
  private let type: OpenedPaperType
  
  var onActionDoJudgmentButton: (() -> Void)?
  
  init(type: OpenedPaperType, frame: CGRect = .zero) {
    self.type = type
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    if type == .ready { setupConstraintsBirds() }
  }
  
  override init(frame: CGRect) {
    self.type = .ready
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    if type == .ready { setupConstraintsBirds() }
  }
  
  required init?(coder: NSCoder) {
    self.type = .ready
    super.init(coder: coder)
    setupViews()
    setupConstraints()
    if type == .ready { setupConstraintsBirds() }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }
  
  private func setupViews() {
    addSubview(paperView)
    addSubview(paperStackView)
    addSubview(readyButton)
    
    [countrySelector, categorySelector, amountTextField].forEach {
      paperStackView.addArrangedSubview($0)
    }
    
    readyButton.addTarget(self, action: #selector(actionJudgmentButton), for: .touchUpInside)
    
    if type == .ready {
      [redBirdImageView, greenBirdImageView, yellowBirdImageView].forEach { addSubview($0) }
      
      [greenBirdChatBubbleView, redBirdChatBubbleView, yellowBirdChatBubbleView].forEach { addSubview($0) }
    }
  }
  
  private func setupConstraints() {
    let topPadding: CGFloat = 34
    let horizentalPadding: CGFloat = 26
    
    NSLayoutConstraint.activate([
      paperView.topAnchor.constraint(equalTo: topAnchor),
      paperView.leadingAnchor.constraint(equalTo: leadingAnchor),
      paperView.trailingAnchor.constraint(equalTo: trailingAnchor),
      paperView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      paperStackView.topAnchor.constraint(equalTo: paperView.topAnchor, constant: topPadding),
      paperStackView.leadingAnchor.constraint(equalTo: paperView.leadingAnchor, constant: horizentalPadding),
      paperStackView.trailingAnchor.constraint(equalTo: paperView.trailingAnchor, constant: -horizentalPadding),
      
      readyButton.topAnchor.constraint(equalTo: paperStackView.bottomAnchor, constant: 28),
      readyButton.leadingAnchor.constraint(equalTo: paperView.leadingAnchor, constant: horizentalPadding),
      readyButton.trailingAnchor.constraint(equalTo: paperView.trailingAnchor, constant: -horizentalPadding),
      readyButton.bottomAnchor.constraint(equalTo: paperView.bottomAnchor, constant: -20)
    ])
  }
  
  private func setupConstraintsBirds() {
    let widthConstant: CGFloat = 94
    let heightConstant: CGFloat = 78
    let overlappingConstant: CGFloat = 9
    
    NSLayoutConstraint.activate([
      greenBirdImageView.widthAnchor.constraint(equalToConstant: widthConstant),
      greenBirdImageView.heightAnchor.constraint(equalToConstant: heightConstant),
      redBirdImageView.widthAnchor.constraint(equalToConstant: widthConstant),
      redBirdImageView.heightAnchor.constraint(equalToConstant: heightConstant),
      yellowBirdImageView.widthAnchor.constraint(equalToConstant: widthConstant),
      yellowBirdImageView.heightAnchor.constraint(equalToConstant: heightConstant),
      
      greenBirdImageView.trailingAnchor.constraint(equalTo: redBirdImageView.leadingAnchor, constant: overlappingConstant),
      greenBirdImageView.bottomAnchor.constraint(equalTo: paperView.topAnchor),
      redBirdImageView.centerXAnchor.constraint(equalTo: paperView.centerXAnchor),
      redBirdImageView.bottomAnchor.constraint(equalTo: paperView.topAnchor),
      yellowBirdImageView.leadingAnchor.constraint(equalTo: redBirdImageView.trailingAnchor, constant: -overlappingConstant),
      yellowBirdImageView.bottomAnchor.constraint(equalTo: paperView.topAnchor),
      
      greenBirdChatBubbleView.bottomAnchor.constraint(equalTo: greenBirdImageView.topAnchor, constant: 12),
      greenBirdChatBubbleView.centerXAnchor.constraint(equalTo: greenBirdImageView.centerXAnchor, constant: 4),
      
      redBirdChatBubbleView.bottomAnchor.constraint(equalTo: redBirdImageView.topAnchor, constant: -30),
      redBirdChatBubbleView.centerXAnchor.constraint(equalTo: redBirdImageView.centerXAnchor, constant: 11),
      
      yellowBirdChatBubbleView.bottomAnchor.constraint(equalTo: yellowBirdImageView.topAnchor, constant: 12),
      yellowBirdChatBubbleView.centerXAnchor.constraint(equalTo: yellowBirdImageView.centerXAnchor, constant: 22)
      
    ])
  }
  
  private func setupLayout() {
    paperView.layer.cornerRadius = 30
    paperView.layer.masksToBounds = true
    readyButton.layer.cornerRadius = 20
    readyButton.layer.masksToBounds = true
  }
  
  func configure(
    paperModel: PaperModel,
    previousRecordExists: Bool = true,
    selected selectedCategory: String = "",
    userAmount: String = "0"
  ) {
    self.countryName = paperModel.selectedCountryProfile.name
    self.selectedCategory = selectedCategory

    countrySelector.configure(
      countries: paperModel.countries.map { $0 },
      selectedCountry: paperModel.selectedCountryProfile.name
    )
    
    categorySelector.configure(
      categoryList: paperModel.categories,
      selected: selectedCategory
    )
    
    amountTextField.configure(
      currency: paperModel.selectedCountryProfile.currency,
      amount: userAmount
    )
    
    updateButtonState(isEnabled: userAmount != "0")
    
    amountTextField.onActionValidInput = { [weak self] validInput in
      guard let self else { return }
      self.updateButtonState(isEnabled: validInput)
    }
  }
  
  func configureBirdsChat(
    previousRecordExists: Bool = true,
    selected selectedCategory: String = ""
  ) {
    self.selectedCategory = selectedCategory
    self.previousRecordExists = previousRecordExists
    configurationBubbleText()
  }
  
  func onActionChange(
    country: @escaping ((String) -> Void),
    category: @escaping ((String?) -> Void),
    amount: @escaping ((String?) -> Void)
  ) {
    countrySelector.onActionChangeCountry = country
    categorySelector.onActionChangeCategory = category
    amountTextField.onActionValidAmountInput = amount
  }
  
  // 특정 조건에 따라 버튼 활성화
  private func updateButtonState(isEnabled: Bool) {
    readyButton.isEnabled = isEnabled
    if isEnabled {
      readyButton.configuration?.background.backgroundColor = .akColor(.akBlue500)
      readyButton.configuration?.baseForegroundColor = .white // 활성화 상태에서 글씨 색상 변경
    } else {
      // 비활성화 상태
      readyButton.configuration?.background.backgroundColor = .akColor(.akGray200)
      readyButton.configuration?.baseForegroundColor = .black
    }
  }
  private func configurationBubbleText() {
    guard let countryName, let selectedCategory else { return }
    print("\(countryName) \(selectedCategory)")
    greenBirdChatBubbleView.textLabel.text = "\(countryName) \(selectedCategory) 기준으로 알려줄게"
    redBirdChatBubbleView.textLabel.text = "한국 \(selectedCategory) 기준으로 알려줄게"
    yellowBirdChatBubbleView.textLabel.text = previousRecordExists ? "직전 기록과 비교해 줄게" : "\(selectedCategory) 첫 기록이다!"
    greenBirdChatBubbleView.alpha = 1
    redBirdChatBubbleView.alpha = 1
    yellowBirdChatBubbleView.alpha = 1
  }
  
  @objc private func actionJudgmentButton() {
    onActionDoJudgmentButton?()
  }
}

#Preview {
  let view = OpenedPaperView(type: .ready)
  view.configure(
    paperModel: .init(
      selectedCountryProfile: .init(
        name: "베트남",
        currency: .init(unitTitle: "동", unit: 0.05539)
      ),
      countries: ["베트남", "스위스"],
      categories: ["가나", "나", "다"]
    ),
    previousRecordExists: false
  )
  
  view.backgroundColor = .blue
  
  return view
}
