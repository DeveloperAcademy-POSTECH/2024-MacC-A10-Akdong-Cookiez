//
//  ExpenseCategoryController.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class ExpenseCategoryController: UIViewController {
  
  // MARK: - Views
  private let budgetTextFieldView = BudgetTextFieldView()
  private let budgetNameSettingView = BudgetNameSettingView()
  private let budgetCategorySettingView = BudgetCategorySettingView()
  private let budgetDeleteButtonView = BudgetDeleteButtonView()
  
  private let stackView = UIStackView().set {
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .fill
    $0.spacing = 20
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
    setupTapGesture()
    setupDeleteButton()
  }
  
  // MARK: - Setup Methods
  private func setupViews() {
    view.backgroundColor = .white
    
    stackView.addArrangedSubview(budgetTextFieldView)
    stackView.addArrangedSubview(budgetNameSettingView)
    stackView.addArrangedSubview(budgetCategorySettingView)
    view.addSubview(stackView)
    view.addSubview(budgetDeleteButtonView)
  }
  
  private func setupConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    budgetDeleteButtonView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .AK.commonLargeHorigentral),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.AK.commonLargeHorigentral),
      
      budgetDeleteButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .AK.commonLargeHorigentral),
      budgetDeleteButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.AK.commonLargeHorigentral),
      budgetDeleteButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -76)
    ])
    
    budgetTextFieldView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
    budgetNameSettingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    budgetCategorySettingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
  }
  
  private func setupTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
  }
  
  private func setupDeleteButton() {
    budgetDeleteButtonView.onDeleteTapped = { [weak self] in
      self?.handleDeleteTapped()
    }
  }
  
  // MARK: - Private Methods
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
  
  private func handleDeleteTapped() {
    // 삭제 로직 구현 예정
  }
}
