//
//  ExpenseSceneTransition.swift
//  AKCOO
//
//  Created by 박혜운 on 11/10/24.
//

import UIKit

class ExpenseSceneTransition: NSObject, UIViewControllerAnimatedTransitioning {
  enum Direction {
    case present
    case dismiss
  }
  
  var animate: (@escaping () -> Void) -> Void = { $0() }
  var direction = Direction.present
  weak var cellView: TravelTableViewCell?
  weak var contentView: UIView?
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5 // 전환 애니메이션 시간
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let cellView, let contentView else {
      transitionContext.completeTransition(false)
      return
    }
    
    if contentView.superview == nil {
      transitionContext.containerView.addSubview(contentView)
      contentView.frame = transitionContext.containerView.bounds
    }
    
    let duration = transitionDuration(using: transitionContext)
    let transition: SnapshotTransition
    
    switch direction {
    case .present:
      print("보여주는 화면")
        transition = SnapshotTransition(
            from: cellView,
            to: contentView,
            in: transitionContext.containerView
        )
    case .dismiss:
        transition = SnapshotTransition(
            from: contentView,
            to: cellView,
            in: transitionContext.containerView
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
