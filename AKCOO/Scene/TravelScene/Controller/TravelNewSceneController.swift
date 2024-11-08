//
//  TravelNewSceneController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class TravelNewSceneController: UIViewController {
  private let travelUseCase: TravelUseCase
  var coordinator: TravelNewCoordinator?
  
  // MARK: - Views
  private let label: UILabel = {
    let label = UILabel()
    label.text = "새로운 여행 생성 완료"
    label.font = .akFont(.gmarketMedium30)
    label.adjustsFontForContentSizeCategory = true
    return label
  }()
  
  // MARK: - Initializers
  init(useCase: TravelUseCase) {
    self.travelUseCase = useCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraints()
  }
  
  // MARK: - Setup Methods
  private func setupView() {
    view.addSubview(label)
    setupNavigationBar()
  }
  
  private func setupConstraints() {
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  private func setupNavigationBar() {
    let nextButton = UIBarButtonItem(
      title: "저장",
      style: .plain,
      target: self,
      action: #selector(didTapAddButton)
    )
    navigationItem.rightBarButtonItem = nextButton
  }
  
  // MARK: - Private Methods
  // MARK: - Actions
  @objc private func didTapAddButton() {
    coordinator?.tappedSaveButton(new: .init(
      country: "태국",
      currency: .init(unitTitle: "바트", unit: 4),
      startDate: .now,
      endDate: .now.addingTimeInterval(3),
      budget: .init(total: 3000000)
    )) // 임시 생성
  }
}
