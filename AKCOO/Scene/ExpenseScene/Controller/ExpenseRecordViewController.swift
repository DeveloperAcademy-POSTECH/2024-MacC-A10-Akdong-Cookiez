//
//  ExpenseRecordViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class ExpenseRecordViewController: UIViewController {
  private let expenseUseCase: ExpenseUseCase
  weak var coordinator: ExpenseCoordinator?
  
  // MARK: - Properties
  private let id: Int

  // MARK: - Views
  private let button: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("하단 버튼", for: .normal)
    return button
  }()

  // MARK: - Initializers
  init(countryId id: Int, expenseUseCase: ExpenseUseCase) {
    self.id = id
    self.expenseUseCase = expenseUseCase
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
    view.addSubview(button)
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }

  private func setupConstraints() {
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.heightAnchor.constraint(equalToConstant: 50),
      button.widthAnchor.constraint(equalToConstant: 200)
    ])
  }

  // MARK: - Private Methods
  // MARK: - Actions
  @objc private func buttonTapped() {
    coordinator?.tappedListButton()
  }
}
