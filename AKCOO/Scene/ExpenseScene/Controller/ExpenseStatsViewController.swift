//
//  ExpenseStatsViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class ExpenseStatsViewController: UIViewController {
  private let expenseUseCase: ExpenseUseCase
  weak var coordinator: ExpenseStatsCoordinator?
  
  // MARK: - Properties
  private let id: Int
  
  // MARK: - Initializers
  init(countryId id: Int, expenseUseCase: ExpenseUseCase) {
    self.id = id
    self.expenseUseCase = expenseUseCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
