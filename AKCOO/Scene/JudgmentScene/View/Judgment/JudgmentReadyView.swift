//
//  JudgmentReadyView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class JudgmentReadyView: UIView {
  var blueBackgroundView = UIView().set {
    $0.backgroundColor = .akColor(.akBlue400)
  }
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
    paperModel: PaperModel,
    previousRecordExists: Bool
  ) {
    paper.configure(
      paperModel: paperModel,
      previousRecordExists: previousRecordExists
    )
    
    configurePreviousRecordExists(previousRecordExists)
  }
  
  func configurePreviousRecordExists(
    _ previousRecordExists: Bool = true,
    selectedCategory: String = ""
  ) {
    paper.configureBirdsChat(
      previousRecordExists: previousRecordExists,
      selected: selectedCategory
    )
  }
  
  private func setupViews() {
    addSubview(blueBackgroundView)
    addSubview(paper)
  }
  
  private func setupConstraints() {
    let paperPadding: CGFloat = 16
    
    NSLayoutConstraint.activate([
      blueBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      blueBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      blueBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      blueBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
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
    ), 
    previousRecordExists: false
  )
  return readyView
}
