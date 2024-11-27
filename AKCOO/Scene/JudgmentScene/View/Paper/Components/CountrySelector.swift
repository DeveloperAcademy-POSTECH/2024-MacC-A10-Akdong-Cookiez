//
//  CountrySelector.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class CountrySelector: UIView {
  
  // MARK: - Views
  let contentStack = UIStackView().set {
    $0.axis = .horizontal
    $0.alignment = .center
    $0.distribution = .fill
    $0.distribution = .equalSpacing
  }
  
  lazy var titleLabel: UILabel = .paperLabel(with: "국가").set()
  
  let countryButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    configuration.imagePadding = 5
    configuration.baseForegroundColor = .black
    configuration.baseBackgroundColor = .clear
    
    let button = UIButton(configuration: configuration)
    return button.set {
      $0.setImage(UIImage(systemName: "chevron.down")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10)), for: .normal)
      $0.semanticContentAttribute = .forceRightToLeft
    }
  }()
  
  private var selectedCountry: String?
  
  // MARK: - OnAction
  var onActionChangeCountry: ((String) -> Void)?
  
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
    addSubview(contentStack)
    
    contentStack.addArrangedSubview(titleLabel)
    contentStack.addArrangedSubview(countryButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
      contentStack.topAnchor.constraint(equalTo: topAnchor),
      contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  // MARK: - Configuration
  func configure(countries: [String], selectedCountry: String) {
    self.selectedCountry = selectedCountry
    self.countryButton.setTitle(selectedCountry, for: .normal)
    self.countryButton.akFont(.gmarketBold16)
    
    setupMenu(countries)
  }
  
  private func setupMenu(_ countries: [String]) {
    let menu = UIMenu(
      title: "", 
      children: countries.map { country in
        UIAction(
          title: country,
          image: country == self.selectedCountry ? UIImage(systemName: "checkmark") : nil,
          handler: { [weak self] _ in
            guard let self else { return }
            self.countryButton.setTitle(country, for: .normal)
            self.countryButton.akFont(.gmarketBold16)
            self.selectedCountry = country
            self.setupMenu(countries)
            self.onActionChangeCountry?(country)
          }
        )
      }
    )
    
    countryButton.menu = menu
    countryButton.showsMenuAsPrimaryAction = true
  }
}

#Preview {
  let countrySelector = CountrySelector()
  countrySelector.configure(
    countries: ["베트남", "스위스"],
    selectedCountry: "베트남"
  )
  
  return countrySelector
}
