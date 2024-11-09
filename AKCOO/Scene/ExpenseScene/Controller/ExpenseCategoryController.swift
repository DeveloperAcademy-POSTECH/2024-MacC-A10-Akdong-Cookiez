//
//  ExpenseCategoryController.swift
//  AKCOO
//
//  Created by 이연정 on 11/9/24.
//

import UIKit

class ExpenseCategoryController: UIViewController {
  
  private let budgetTextFieldView = BudgetTextFieldView()
  private let budgetNameSettingView = BudgetNameSettingView()
  private let budgetCategorySettingView = BudgetCategorySettingView()
  
  private let stackView = UIStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }
  
  private func setupViews() {
    view.backgroundColor = .white
    
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.alignment = .fill
    stackView.spacing = 0
    
    budgetTextFieldView.backgroundColor = .red.withAlphaComponent(0.3)
    budgetNameSettingView.backgroundColor = .green.withAlphaComponent(0.3)
    budgetCategorySettingView.backgroundColor = .blue.withAlphaComponent(0.3)
    
    stackView.addArrangedSubview(budgetTextFieldView)
    stackView.addArrangedSubview(budgetNameSettingView)
    stackView.addArrangedSubview(budgetCategorySettingView)
    
    view.addSubview(stackView)
  }
  
  private func setupConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
      stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    
    budgetTextFieldView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    budgetNameSettingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
    budgetCategorySettingView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    view.layoutIfNeeded()
  }
}
