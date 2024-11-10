//
//  budgetDeleteButtonView.swift
//  AKCOO
//
//  Created by 이연정 on 11/10/24.
//

import UIKit

class BudgetDeleteButtonView: UIView {
  
  private let deleteButton = UIButton().set {
    $0.setTitle("지출내역 삭제", for: .normal)
    $0.setTitleColor(.akColor(.black), for: .normal)
    $0.backgroundColor = .akColor(.akGreen)
    $0.titleLabel?.font = UIFont.akFont(.gmarketMedium16)
    $0.titleLabel?.adjustsFontForContentSizeCategory = true
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentEdgeInsets = UIEdgeInsets(top: 18, left: 0, bottom: 18, right: 0)
  }
  
  var onDeleteTapped: (() -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView() {
    addSubview(deleteButton)
    
    NSLayoutConstraint.activate([
      deleteButton.topAnchor.constraint(equalTo: topAnchor),
      deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor),
      deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    deleteButton.layer.cornerRadius = deleteButton.bounds.height / 2
  }
  
  @objc private func deleteButtonTapped() {
    onDeleteTapped?()
  }
}
