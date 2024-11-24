//
//  OpenedPaperView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class OpenedPaperView: UIView {
  let paperStackView = UIStackView().set {
    $0.axis = .vertical
    $0.alignment = .fill
    $0.distribution = .fill
    $0.spacing = 23
  }
  
  let paperView = UIView(frame: .zero).set {
    $0.backgroundColor = .akColor(.white)
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
  
  private let greenBirdImageView = UIImageView().set {
    $0.image = BirdCharacterImageType.foriegn.basic
    $0.contentMode = .scaleAspectFit
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private let redBirdImageView = UIImageView().set {
    $0.image = BirdCharacterImageType.local.basic
    $0.contentMode = .scaleAspectFit
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private let yellowBirdImageView = UIImageView().set {
    $0.image = BirdCharacterImageType.previous.basic
    $0.contentMode = .scaleAspectFit
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  var onActionDoJudgmentButton: (() -> Void)?
  
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }
  
  private func setupViews() {
    addSubview(paperView)
    addSubview(paperStackView)
    addSubview(readyButton)
    [greenBirdImageView, redBirdImageView, yellowBirdImageView].forEach { addSubview($0) }
    
    [countrySelector, categorySelector, amountTextField].forEach {
      paperStackView.addArrangedSubview($0)
    }
    
    readyButton.addTarget(self, action: #selector(actionJudgmentButton), for: .touchUpInside)
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
    
    setupConstraintsBirds()
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
      yellowBirdImageView.bottomAnchor.constraint(equalTo: paperView.topAnchor)
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
    selected selectedCategory: String = ""
  ) {
    countrySelector.configure(
      countries: paperModel.countries.map { $0 },
      selectedCountry: paperModel.selectedCountryProfile.name
    )
    
    categorySelector.configure(
      categoryList: paperModel.categories,
      selected: selectedCategory
    )
    
    amountTextField.configure(
      currency: paperModel.selectedCountryProfile.currency
    )
    
    amountTextField.onActionValidInput = { [weak self] validInput in
      guard let self else { return }
      self.updateButtonState(isEnabled: validInput)
    }
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
  
  @objc private func actionJudgmentButton() {
    onActionDoJudgmentButton?()
  }
}

#Preview {
  let view = OpenedPaperView()
  view.configure(
    paperModel: .init(
      selectedCountryProfile: .init(
        name: "베트남",
        currency: .init(unitTitle: "동", unit: 0.05539)
      ),
      countries: ["베트남", "스위스"],
      categories: ["가나", "나", "다"]
    )
  )
  
  return view
}
