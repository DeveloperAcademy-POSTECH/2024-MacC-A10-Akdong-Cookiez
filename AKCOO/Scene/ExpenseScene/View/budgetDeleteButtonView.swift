//
//  budgetDeleteButtonView.swift
//  AKCOO
//
//  Created by 이연정 on 11/10/24.
//

import UIKit

class BudgetDeleteButtonView: UIView {
  
  // MARK: - Views
  private lazy var deleteButton = UIButton().set {
    $0.setTitle("지출내역 삭제", for: .normal)
    $0.contentEdgeInsets = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
    $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    
    $0.setTitleColor(.akColor(.black), for: .normal)
    $0.backgroundColor = .akColor(.akGreen)
    $0.titleLabel?.font = UIFont.akFont(.gmarketMedium16)
    $0.titleLabel?.adjustsFontForContentSizeCategory = true
  }
  
  // MARK: - Output
  var onDeleteTapped: (() -> Void)?
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  // MARK: - Setup Methods
  private func setupView() {
    addSubview(deleteButton)
    setConstraints()
    deleteButton.layer.cornerRadius = deleteButton.bounds.height / 2
  }
  
  private func setConstraints() {
    NSLayoutConstraint.activate([
      deleteButton.topAnchor.constraint(equalTo: topAnchor),
      deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  // MARK: - Private Methods
  @objc private func deleteButtonTapped() {
    onDeleteTapped?()
  }
}
