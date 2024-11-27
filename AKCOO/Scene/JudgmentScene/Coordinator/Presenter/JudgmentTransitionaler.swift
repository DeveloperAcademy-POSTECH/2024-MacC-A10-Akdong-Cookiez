//
//  StartTransitionaler.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class JudgmentTransitionaler: NSObject, UIViewControllerTransitioningDelegate {
  let transition = JudgmentTransition()
  
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .present
    transition.judgmentReadyView = (source as? JudgmentReadyViewController)?.view as? JudgmentReadyView
    transition.judgmentView = (presented as? JudgmentCompletedViewController)?.view as? JudgmentView
    return transition
  }
  
  func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .dismiss
    return transition
  }
}
