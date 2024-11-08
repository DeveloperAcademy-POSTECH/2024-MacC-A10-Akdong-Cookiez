//
//  ExpenseSceneController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class ExpenseSceneController: UIViewController {
  private let recordViewController: ExpenseRecordViewController
  private let statsViewController: ExpenseStatsViewController

  // MARK: - Views
  let label: UILabel = { // 화면 구분을 위한 임시생성
    let label = UILabel()
    label.text = "ExpenseSceneController"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Initializers
  init(recordViewController: ExpenseRecordViewController, statsViewController: ExpenseStatsViewController) {
    self.recordViewController = recordViewController
    self.statsViewController = statsViewController
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
    addChild(recordViewController)
    view.addSubview(recordViewController.view)
    recordViewController.didMove(toParent: self)

    view.addSubview(label)
  }

  private func setupConstraints() {
    recordViewController.view.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      recordViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      recordViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
