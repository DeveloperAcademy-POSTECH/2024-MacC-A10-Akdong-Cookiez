//
//  JudgmentReadyView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class JudgmentReadyView: UIView {
  lazy var paper = OpenedPaperView().set()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
    setConstraints()
  }
  
  private func setupView() {
    backgroundColor = .blue
    addSubview(paper)
  }
  
  private func setConstraints() {
    let paperPadding: CGFloat = 16
    NSLayoutConstraint.activate([
      paper.centerYAnchor.constraint(equalTo: centerYAnchor),
      paper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paperPadding),
      paper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paperPadding)
    ])
  }
}

#Preview {
  JudgmentReadyView()
}
