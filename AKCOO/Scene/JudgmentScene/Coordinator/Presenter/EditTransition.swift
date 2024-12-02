//
//  EditTransition.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class EditTransition: NSObject, UIViewControllerAnimatedTransitioning {
  enum Direction {
    case present
    case dismiss
  }
  
  var animate: (@escaping () -> Void) -> Void = { $0() }
  var direction = Direction.present
  weak var judgmentView: JudgmentView?
  weak var judgmentEditView: JudgmentEditView?
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3 // 전환 애니메이션 시간
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let judgmentEditView, let judgmentView else {
      transitionContext.completeTransition(false)
      return
    }
    if judgmentEditView.superview == nil {
      transitionContext.containerView.addSubview(judgmentEditView)
      judgmentEditView.frame = transitionContext.containerView.bounds
    }
    
    let duration = transitionDuration(using: transitionContext)
    let transition: SnapshotTransition
    switch direction {
    case .present:
      transition = SnapshotTransition(
        from: judgmentView,
        to: judgmentEditView,
        in: transitionContext.containerView,
        childTransitions: [
          (from: judgmentView.blueBackgroundView, to: judgmentEditView.blueBackgroundView, action: .move),
          (from: judgmentView.paper.paperView, to: judgmentEditView.paper.paperView, action: .move)
        ]
      )
    case .dismiss:
      let textField = createTextSnapshot(from: judgmentEditView.paper.amountTextField.textField)
      
      transition = SnapshotTransition(
        from: judgmentEditView,
        to: judgmentView,
        in: transitionContext.containerView,
        childTransitions: [
          (from: judgmentEditView.blueBackgroundView, to: judgmentView.blueBackgroundView, action: .move),
          (from: judgmentEditView.paper.paperView, to: judgmentView.paper.paperView, action: .move),
          (from: judgmentEditView.paper.amountTextField.infoLabel, to: judgmentView.paper.convertKRWLabel, action: .move),
          (from: textField, to: judgmentView.paper.amountLabel, action: .move),
          (from: judgmentEditView.paper.amountTextField.unitLabel, to: judgmentView.paper.unitTitleLabel, action: .move),
          (from: judgmentEditView.paper.amountTextField.separatorLine, to: judgmentView.paper.separatorLine, action: .move),
          (from: judgmentEditView.paper.countrySelector.countryLabel, to: judgmentView.paper.countryLabel, action: .move),
          (from: judgmentEditView.paper.categorySelector.selectedButton ?? .init(), to: judgmentView.paper.category, action: .move),
          (from: judgmentView.paper.reInputTextView, to: judgmentView.paper.reInputTextView, action: .appear),
          (from: judgmentView.paperTitleLabel, to: judgmentView.paperTitleLabel, action: .appear),
          (from: judgmentView.birdsReactionTitleLabel, to: judgmentView.birdsReactionTitleLabel, action: .appear),
          (from: judgmentEditView.paper.countrySelector.titleLabel, to: judgmentView.paper.paperView, action: .disappear),
          (from: judgmentEditView.paper.categorySelector.titleLabel, to: judgmentView.paper.paperView, action: .disappear),
          (from: judgmentEditView.paper.amountTextField.titleLabel, to: judgmentView.paper.paperView, action: .disappear),
          (from: judgmentEditView.paper.readyButton, to: judgmentView.paper.paperView, action: .disappear)
        ]
      )
    }
    transition.prepare()
    
    animate {
      UIView.animateKeyframes(
        withDuration: duration,
        delay: 0,
        options: [],
        animations: { transition.addKeyframes() },
        completion: { finished in
          transition.cleanUp()
          let completed = finished && !transitionContext.transitionWasCancelled
          transitionContext.completeTransition(completed)
        }
      )
    }
  }
  
  func createTextSnapshot(from textField: UITextField) -> UIView {
    guard let text = textField.text, !text.isEmpty else {
      return UIView(frame: .zero) // 텍스트가 없을 경우 빈 뷰 반환
    }
    
    // 텍스트 크기 계산
    let font = textField.font ?? UIFont.systemFont(ofSize: 14)
    let textSize = text.size(withAttributes: [.font: font])
    
    // 텍스트 필드 내부 텍스트 영역 계산
    let textRect = textField.textRect(forBounds: textField.bounds)
    
    // 전체 좌표계로 변환
    let convertedTextRect = textField.convert(textRect, to: nil)
    
    // Trailing 기준으로 위치 보정
    let adjustedOrigin = CGPoint(
      x: convertedTextRect.maxX - textSize.width, // Trailing 위치 보정
      y: convertedTextRect.origin.y + (textRect.height - textSize.height) / 2 // y 중심 맞추기
    )
    
    // 스냅샷 뷰 생성
    let snapshotView = UIView(frame: CGRect(origin: adjustedOrigin, size: textSize))
    snapshotView.backgroundColor = .clear
    
    // 텍스트 레이블 추가
    let textLabel = UILabel(frame: snapshotView.bounds)
    textLabel.text = text
    textLabel.font = font
    textLabel.textColor = textField.textColor
    textLabel.textAlignment = .right // Trailing 정렬로 표시
    
    snapshotView.addSubview(textLabel)
    return snapshotView
  }
}
