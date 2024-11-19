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
    $0.spacing = 8
  }
  
  let titleLabel = UILabel().set {
    $0.text = "Select Country"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
  }
  
  let countryButton = UIButton(type: .system).set {
    $0.setTitle("베트남", for: .normal)
    $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    $0.tintColor = .black
    $0.setTitleColor(.black, for: .normal)
    $0.semanticContentAttribute = .forceRightToLeft
  }
  
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
  
  // MARK: - Setup Methods
  private func setupView() {
    setupMenu()
    contentStack.addArrangedSubview(titleLabel)
    contentStack.addArrangedSubview(countryButton)
    
    addSubview(contentStack)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
      contentStack.topAnchor.constraint(equalTo: topAnchor),
      contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  // MARK: - Actions
  private func setupMenu() {
    let menu = UIMenu(title: "", children: [
      UIAction(title: "베트남", handler: { _ in
        self.countryButton.setTitle("베트남", for: .normal)
      }),
      UIAction(title: "스위스", handler: { _ in
        self.countryButton.setTitle("스위스", for: .normal)
      })
    ])
    
    countryButton.menu = menu
    countryButton.showsMenuAsPrimaryAction = true
  }
}

#Preview {
  CountrySelector()
}
