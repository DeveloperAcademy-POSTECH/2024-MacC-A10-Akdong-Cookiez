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
  
  var closedButton: UIButton = {
    var configuration = UIButton.Configuration.plain()
    configuration.imagePadding = 0 // 기본 이미지 패딩 제거
    configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .regular)
    let image = UIImage(systemName: "xmark", withConfiguration: symbolConfig)
    let button = UIButton(configuration: configuration)
    return button.set {
      $0.setImage(image, for: .normal)
      $0.frame = CGRect(x: 0, y: 0, width: 21, height: 21) // 터치 영역 확장
      $0.tintColor = .black
    }
  }()
  
  var paper = OpenedPaperView().set()
  var paperBottomConstraint: NSLayoutConstraint?
  var paperCenterYConstraint: NSLayoutConstraint?
  
  var onActionTappedClosedButton: (() -> Void)?
  
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
    addSubview(closedButton)
    addSubview(paper)
    
    closedButton.addTarget(self, action: #selector(tappedClosedButton), for: .touchUpInside)
  }
  
  private func setupConstraints() {
    let paperPadding: CGFloat = 16
    
    NSLayoutConstraint.activate([
      blueBackgroundView.topAnchor.constraint(equalTo: topAnchor),
      blueBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      blueBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      blueBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      closedButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      closedButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 13),
      
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
  
  @objc private func tappedClosedButton() {
    onActionTappedClosedButton?()
  }
}

#Preview {
  let readyView = JudgmentReadyView()
  readyView
    .configure(
    paperModel: .init(
      selectedCountryProfile: .init(
        name: "베트남",
        currency: .init(
          unitTitle: "동", unit: 0.05539
        )
      ),
      categories: ["가", "나", "다"]
    ), 
    previousRecordExists: false
  )
  return readyView
}
