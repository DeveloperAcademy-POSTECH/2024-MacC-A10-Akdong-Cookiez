//
//  OpenedPaperView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class OpenedPaperView: UIView {
  let paperBackgroundView = UIView(frame: .zero).set()
  let paper = UIView(frame: .zero).set()
  let countrySelector = CountrySelector().set()
  let categorySelector = CategorySettingView().set()
  let textField = AmountMoneyTextField().set()
  
  let readyButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 19, leading: 0, bottom: 19, trailing: 0)
    let button = UIButton(configuration: configuration)
    return button.set {
      $0.setTitle("지출 판단하기", for: .normal)
      $0.backgroundColor = .systemGreen
      $0.setTitleColor(.white, for: .normal)
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
      $0.layer.cornerRadius = 20
    }
  }()
  
  var tappedJudgmentButton: (() -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
    setConstraints()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setLayout()
  }
  
  func setupView() {
    paperBackgroundView.backgroundColor = .white
    
    paperBackgroundView.addSubview(paper)
    paperBackgroundView.addSubview(countrySelector)
    paperBackgroundView.addSubview(categorySelector)
    paperBackgroundView.addSubview(textField)
    
    addSubview(paperBackgroundView)
    addSubview(readyButton)
    
    readyButton.addTarget(self, action: #selector(actionJudgmentButton), for: .touchUpInside)
  }
  
  func setConstraints() {
    let horizentalPadding: CGFloat = 26
    
    NSLayoutConstraint.activate([
      paper.topAnchor.constraint(equalTo: topAnchor),
      paper.leadingAnchor.constraint(equalTo: leadingAnchor),
      paper.trailingAnchor.constraint(equalTo: trailingAnchor),
      paper.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      paperBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      paperBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      paperBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      paperBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      countrySelector.topAnchor.constraint(equalTo: paperBackgroundView.topAnchor, constant: 46),
      countrySelector.leadingAnchor.constraint(equalTo: paperBackgroundView.leadingAnchor, constant: horizentalPadding),
      countrySelector.trailingAnchor.constraint(equalTo: paperBackgroundView.trailingAnchor, constant: -horizentalPadding),
      countrySelector.bottomAnchor.constraint(equalTo: categorySelector.topAnchor),
      
      categorySelector.leadingAnchor.constraint(equalTo: paperBackgroundView.leadingAnchor, constant: horizentalPadding),
      categorySelector.trailingAnchor.constraint(equalTo: paperBackgroundView.trailingAnchor, constant: -horizentalPadding),
      categorySelector.bottomAnchor.constraint(equalTo: textField.topAnchor),
      
      textField.leadingAnchor.constraint(equalTo: paperBackgroundView.leadingAnchor, constant: horizentalPadding),
      textField.trailingAnchor.constraint(equalTo: paperBackgroundView.trailingAnchor, constant: -horizentalPadding),
      textField.bottomAnchor.constraint(equalTo: readyButton.topAnchor),
      
      readyButton.leadingAnchor.constraint(equalTo: paperBackgroundView.leadingAnchor, constant: horizentalPadding),
      readyButton.trailingAnchor.constraint(equalTo: paperBackgroundView.trailingAnchor, constant: -horizentalPadding),
      readyButton.bottomAnchor.constraint(equalTo: paperBackgroundView.bottomAnchor, constant: -46)
      
    ])
    categorySelector.backgroundColor = .blue
  }
  
  private func setLayout() {
    paperBackgroundView.layer.cornerRadius = 30
    paperBackgroundView.layer.masksToBounds = true
  }
  
  @objc private func actionJudgmentButton() {
    tappedJudgmentButton?()
  }
}

#Preview {
  OpenedPaperView()
}
