//
//  JudgmentReadyView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class JudgmentReadyView: UIView {
  var paper = OpenedPaperView().set()
  var paperBottomConstraint: NSLayoutConstraint?
  var paperCenterYConstraint: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
  
  func configure(
    paperModel: PaperModel
  ) {
    paper.configure(paperModel: paperModel)
  }
  
  private func setupViews() {
    addSubview(paper)
  }
  
  private func setupConstraints() {
    let paperPadding: CGFloat = 16
    
    NSLayoutConstraint.activate([
      paper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paperPadding),
      paper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paperPadding)
    ])
    
    paperBottomConstraint?.priority = UILayoutPriority(750) // 낮은 우선순위 부여
    paperBottomConstraint = paper.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paperPadding)
    paperCenterYConstraint = paper.centerYAnchor.constraint(equalTo: centerYAnchor)
    paperCenterYConstraint?.isActive = true
  }
  
  func adjustPaperPositionForKeyboard(
    isVisible: Bool,
    keyboardHeight: CGFloat = 0,
    bottomPadding: CGFloat = 0
  ) {
    paperCenterYConstraint?.isActive = false
    paperBottomConstraint?.isActive = false
    if isVisible {
      paperBottomConstraint?.constant = -(keyboardHeight + bottomPadding)
      paperBottomConstraint?.isActive = true
    } else {
      paperCenterYConstraint?.isActive = true
    }
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
}

#Preview {
  let readyView = JudgmentReadyView()
  readyView.configure(
    paperModel: .init(
      selectedCountryProfile: .init(
        name: "베트남",
        currency: .init(
          unitTitle: "동", unit: 0.05539
        )
      ), 
      countries: ["베트남", "스위스"],
      categories: ["가", "나", "다"]
    )
  )
  return readyView
}
