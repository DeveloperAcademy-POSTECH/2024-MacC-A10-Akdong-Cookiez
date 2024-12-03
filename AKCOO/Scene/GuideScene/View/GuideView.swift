//
//  GuideView.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import SwiftUI
import UIKit

class GuideView: UIView {
  
  let grayBackgroundView = UIView().set {
    $0.backgroundColor = .akColor(.akGray100)
  }
  
  let userInfoButton = UIButton().set {
    $0.tintColor = .red
    $0.setImage(UIImage(resource: .userInfoButton), for: .normal)
    $0.imageView?.contentMode = .scaleAspectFit
  }
  
  let judgmentButton = {
    var configuration = UIButton.Configuration.filled()
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 22, leading: 0, bottom: 22, trailing: 0)
    configuration.background.backgroundColor = .akColor(.akBlue500)
    configuration.baseForegroundColor = .white
    let button = UIButton(configuration: configuration)
    return button.set {
      $0.setTitle("여행 시작하기", for: .normal)
      $0.akFont(.gmarketBold16)
      $0.layer.cornerRadius = 20
      $0.layer.masksToBounds = true
    }
  }()
  
  let countrySelectorTitle = CountrySelectorTitle().set()
  
  private let priceLevelViewModel = GuidePriceLevelByCountryViewModel()
  lazy var priceLevelView = UIHostingController(rootView: GuidePriceLevelByCountryView(viewModel: priceLevelViewModel)).view.set {
    $0.backgroundColor = .clear
  }
  
  var onActionUserInfoTapped: (() -> Void)? // 임시 생성
  var onActionJudgmentTapped: (() -> Void)? // 임시 생성
  
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
  
  private func setupViews() {
    self.addSubview(grayBackgroundView)
    self.addSubview(countrySelectorTitle)
    self.addSubview(userInfoButton)
    self.addSubview(judgmentButton)
    self.addSubview(priceLevelView)
    
    userInfoButton.addTarget(self, action: #selector(tappedUserInfoBird), for: .touchUpInside)
    
    judgmentButton.addTarget(self, action: #selector(tappedStartJudgment), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      grayBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      grayBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      grayBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      grayBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      countrySelectorTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
      countrySelectorTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33),
      countrySelectorTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33),
      
      userInfoButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
      userInfoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33),
      userInfoButton.widthAnchor.constraint(equalToConstant: 40),
      userInfoButton.heightAnchor.constraint(equalToConstant: 40),
      
      priceLevelView.topAnchor.constraint(equalTo: countrySelectorTitle.bottomAnchor, constant: 80),
      priceLevelView.leadingAnchor.constraint(equalTo: leadingAnchor),
      priceLevelView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      judgmentButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 33),
      judgmentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -33),
      judgmentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
    ])
  }
  
  func configure(countries: [String], selectedCountryDetail: CountryDetail) {
    priceLevelViewModel.countryDetail = selectedCountryDetail
    
    countrySelectorTitle
      .configure(
        countries: countries,
        selectedCountry: selectedCountryDetail.name
      )
  }
  
  @objc func tappedUserInfoBird() {
    onActionUserInfoTapped?()
  }
  
  @objc func tappedStartJudgment() {
    onActionJudgmentTapped?()
  }
}

#Preview {
  GuideViewController(guideUseCase: GuideUseCaseMock())
}
