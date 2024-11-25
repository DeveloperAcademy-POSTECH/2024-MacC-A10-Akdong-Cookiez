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
          (from: judgmentView.paper, to: judgmentEditView.paper.paperView)
        ]
      )
    case .dismiss:
      transition = SnapshotTransition(
        from: judgmentEditView,
        to: judgmentView,
        in: transitionContext.containerView,
        childTransitions: [
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
}
