//
//  ExpenseSceneController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import UIKit

class ExpenseSceneController: UIViewController {
  private let recordViewController: UIViewController
  private let statsViewController: UIViewController

  // MARK: - Views
  
  // MARK: - Initializers
  init(recordViewController: UIViewController, statsViewController: UIViewController) {
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
  }

  private func setupConstraints() {
    recordViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      recordViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      recordViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      recordViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      recordViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}
