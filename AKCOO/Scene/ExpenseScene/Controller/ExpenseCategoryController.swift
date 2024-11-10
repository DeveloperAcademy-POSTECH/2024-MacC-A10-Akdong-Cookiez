//
//  ExpenseCategoryController.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class ExpenseCategoryController: UIViewController {
  
  // MARK: - Properties
  private let budgetTextFieldView = BudgetTextFieldView()
  private let budgetNameSettingView = BudgetNameSettingView()
  private let budgetCategorySettingView = BudgetCategorySettingView()
  private let budgetDeleteButtonView = BudgetDeleteButtonView()
  
  private let stackView = UIStackView()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
    setupTapGesture()
    setupDeleteButton()
  }
  
  // MARK: - UI Setup
  private func setupViews() {
    view.backgroundColor = .white
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    budgetDeleteButtonView.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(stackView)
    view.addSubview(budgetDeleteButtonView)
    
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .fill
    stackView.spacing = 20
    
    stackView.addArrangedSubview(budgetTextFieldView)
    stackView.addArrangedSubview(budgetNameSettingView)
    stackView.addArrangedSubview(budgetCategorySettingView)
  }
  
  // MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      
      budgetDeleteButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      budgetDeleteButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      budgetDeleteButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -76)
    ])
    
    budgetTextFieldView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150).isActive = true
    budgetNameSettingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    budgetCategorySettingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
  }
  
  // MARK: - Gesture Recognizers
  private func setupTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
  }
  
  // MARK: - Button Actions
  private func setupDeleteButton() {
    budgetDeleteButtonView.onDeleteTapped = { [weak self] in
      self?.handleDeleteTapped()
    }
  }
  
  // MARK: - Helper Methods
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
  
  private func handleDeleteTapped() {
    // 삭제 로직 구현 예정
  }
}
