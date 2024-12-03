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
  
  private var selectedCountryDetail: CountryDetail?
  
  init(guideUseCase: GuideUseCase) {
    self.guideUseCase = guideUseCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = GuideView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Task { await configure() }
    onAction()
  }
  
  private func configure() async {
    guard case let .success((countriesName, selectedCountryDetail)) = await guideUseCase.getGuideInfo() else { return } // 예외처리
    self.selectedCountryDetail = selectedCountryDetail
    
    guideView.configure(countries: countriesName, selectedCountry: selectedCountryDetail.name)
  }
  
  private func onAction() {
    guideView.onActionUserInfoTapped = { [weak self] in
      guard let self else { return }
      self.coordinator?.startUserInfo()
    }
    
    guideView.onActionJudgmentTapped = { [weak self] in
      guard let self else { return }
      guard let selectedCountryDetail else { return }
      self.coordinator?.startJudgmentReady(
        presenting: self,
        selectedCountryDetail: selectedCountryDetail
      )
    }
    
    guideView.countrySelectorTitle.onActionChangeCountry = { [weak self] newCountry in
      Task {
        guard let self else { return }
        guard let selectedCountryDetail = self.selectedCountryDetail else { return }
        guard case let .success((countriesName, selectedCountryDetail)) = await self.guideUseCase.getNewGuideInfo(newCountryName: newCountry) else { return }
        
        self.selectedCountryDetail = selectedCountryDetail
        self.guideView.configure(countries: countriesName, selectedCountry: selectedCountryDetail.name)
      }
    }
  }
}

#Preview {
  GuideViewController(guideUseCase: GuideUseCaseMock())
}
