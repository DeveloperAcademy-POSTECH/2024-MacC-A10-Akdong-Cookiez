//
//  GuideViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import UIKit

class GuideViewController: UIViewController {
  weak var coordinator: GuideCoordinator?
  private let guideUseCase: GuideUseCase
  
  // MARK: View
  private var guideView: GuideView! {
    return view as? GuideView
  }
  
  private var selectedCountry: String = ""
  
  init(guideUseCase: GuideUseCase) {
    self.guideUseCase = guideUseCase
    super.init(nibName: nil, bundle: nil)
    
    selectedCountry = "스위스" // CountryDetail 받아올 때 초기화
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = GuideView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    onAction()
  }
  
  private func configure() {
    guard case let .success(countries) = guideUseCase.getCountryNames() else { return } // 예외처리
    guideView.configure(countries: countries, selectedCountry: selectedCountry)
  }
  
  private func onAction() {
    guideView.onActionUserInfoTapped = { [weak self] in
      guard let self else { return }
      self.coordinator?.startUserInfo()
    }
    
    guideView.onActionJudgmentTapped = { [weak self] in
      guard let self else { return }
      self.coordinator?.startJudgmentReady(presenting: self)
    }
    
    guideView.countrySelectorTitle.onActionChangeCountry = { [weak self] newCountry in
      guard let self else { return }
      _ = self.guideUseCase.getNewCountryDetail(newCountryName: newCountry)
      // selectedCountry 도 변경
    }
  }
}

#Preview {
  GuideViewController(guideUseCase: GuideUseCaseMock())
}
