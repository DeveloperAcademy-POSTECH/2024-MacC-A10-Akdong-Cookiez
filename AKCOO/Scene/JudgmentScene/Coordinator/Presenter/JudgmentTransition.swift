//  StartTransition.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.

import UIKit

class JudgmentTransition: NSObject, UIViewControllerAnimatedTransitioning {
  enum Direction {
    case present
    case dismiss
  }
  
  var animate: (@escaping () -> Void) -> Void = { $0() }
  var direction = Direction.present
  weak var judgmentReadyView: JudgmentReadyView?
  weak var judgmentView: JudgmentView?
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3 // 전환 애니메이션 시간
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let judgmentReadyView, let judgmentView else {
      transitionContext.completeTransition(false)
      return
    }
    if judgmentView.superview == nil {
      transitionContext.containerView.addSubview(judgmentView)
      judgmentView.frame = transitionContext.containerView.bounds
    }
    
    let duration = transitionDuration(using: transitionContext)
    
    let transition: SnapshotTransition
    switch direction {
    case .present:
      
      let greenBird = judgmentReadyView.paper.greenBirdImageView
      let redBird = judgmentReadyView.paper.redBirdImageView
      let yellowBird = judgmentReadyView.paper.yellowBirdImageView
      
      greenBird.image = BirdCharacterImageType.foriegn.wingL
      redBird.image = BirdCharacterImageType.local.wingL
      yellowBird.image = BirdCharacterImageType.previous.wingR
      
      let textField = createTextSnapshot(from: judgmentReadyView.paper.amountTextField.textField)
      
      transition = SnapshotTransition(
        from: judgmentReadyView,
        to: judgmentView,
        in: transitionContext.containerView,
        childTransitions: [
          (from: judgmentReadyView.blueBackgroundView, to: judgmentView.blueBackgroundView, action: .move),
          (from: judgmentReadyView.paper.paperView, to: judgmentView.paper.paperView, action: .move),
          (from: judgmentReadyView.paper.amountTextField.infoLabel, to: judgmentView.paper.convertKRWLabel, action: .move),
          (from: textField, to: judgmentView.paper.amountLabel, action: .move),
          (from: judgmentReadyView.paper.amountTextField.unitLabel, to: judgmentView.paper.unitTitleLabel, action: .move),
          (from: judgmentReadyView.paper.amountTextField.separatorLine, to: judgmentView.paper.separatorLine, action: .move),
          (from: judgmentReadyView.paper.countrySelector.countryLabel, to: judgmentView.paper.countryLabel, action: .move),
          (from: judgmentReadyView.paper.categorySelector.selectedButton ?? .init(), to: judgmentView.paper.category, action: .move),
          (from: judgmentView.paper.reInputTextView, to: judgmentView.paper.reInputTextView, action: .appear),
          (from: judgmentView.paperTitleLabel, to: judgmentView.paperTitleLabel, action: .appear),
          (from: judgmentView.birdsReactionTitleLabel, to: judgmentView.birdsReactionTitleLabel, action: .appear),
          (from: judgmentReadyView.paper.countrySelector.titleLabel, to: judgmentView.paper.paperView, action: .disappear),
          (from: judgmentReadyView.paper.categorySelector.titleLabel, to: judgmentView.paper.paperView, action: .disappear),
          (from: judgmentReadyView.paper.amountTextField.titleLabel, to: judgmentView.paper.paperView, action: .disappear),
          (from: judgmentReadyView.paper.readyButton, to: judgmentView.paper.paperView, action: .disappear),
          (from: greenBird, to: greenBird, action: .moveTo(dx: -300, dy: -300)),
          (from: redBird, to: redBird, action: .moveTo(dx: 0, dy: -300)),
          (from: yellowBird, to: yellowBird, action: .moveTo(dx: 300, dy: -300))
        ]
      )
      
    case .dismiss:
      let greenBird = judgmentReadyView.paper.greenBirdImageView
      let redBird = judgmentReadyView.paper.redBirdImageView
      let yellowBird = judgmentReadyView.paper.yellowBirdImageView
      
      greenBird.image = BirdCharacterImageType.foriegn.basic
      redBird.image = BirdCharacterImageType.local.basic
      yellowBird.image = BirdCharacterImageType.previous.basic
      
      transition = SnapshotTransition(
        from: judgmentView,
        to: judgmentReadyView,
        in: transitionContext.containerView,
        childTransitions: [
          (from: judgmentView.blueBackgroundView, to: judgmentReadyView.blueBackgroundView, action: .move)
        ]
      )
    }
    
    transition.prepare()
    animate {
      UIView.animateKeyframes(
        withDuration: self.direction == .present ? duration : 0.0,
        delay: 0,
        options: [],
        animations: {
          transition.addKeyframes()
        },
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
