//
//  CountrySelectorTitle.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import UIKit

class CountrySelectorTitle: UIView {
  
  // MARK: - Views
  let contentStack = UIStackView().set {
    $0.axis = .vertical
    $0.alignment = .leading
    $0.distribution = .fill
    $0.distribution = .equalSpacing
  }
  
  lazy var explanationLabel = UILabel().set {
    $0.text = "여행중이신가요?"
    $0.font = .akFont(.gmarketMedium30)
  }
  
  let countryButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    configuration.imagePadding = 5
    configuration.baseForegroundColor = .black
    configuration.baseBackgroundColor = .clear
    configuration.imagePlacement = .trailing
    
    let button = UIButton(configuration: configuration)
    
    return button.set {
      $0.setImage(
        UIImage(systemName: "chevron.down")?
          .withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)),
        for: .normal
      )
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
    
    contentStack.addArrangedSubview(countryButton)
    contentStack.addArrangedSubview(explanationLabel)
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
    
    configureButton(selectedCountry: selectedCountry)
    
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
            
            self.configureButton(selectedCountry: country)
            
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
  
  private func configureButton(selectedCountry: String) {
    let attributedString = NSAttributedString(
      string: selectedCountry,
      attributes: [
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .font: UIFont.akFont(.gmarketBold30) as Any,
        .baselineOffset: 8
      ]
    )
    
    countryButton.setAttributedTitle(attributedString, for: .normal)
  }
}

#Preview {
  let countrySelector = CountrySelectorTitle()
  countrySelector.configure(
    countries: ["베트남", "스위스"],
    selectedCountry: "베트남"
  )
  
  return countrySelector
}
