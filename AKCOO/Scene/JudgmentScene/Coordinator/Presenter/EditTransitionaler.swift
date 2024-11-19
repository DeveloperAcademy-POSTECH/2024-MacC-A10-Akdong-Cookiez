//
//  EditTransitionaler.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class EditTransitionaler: NSObject, UIViewControllerTransitioningDelegate {
  let transition = EditTransition()
  
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .present
    transition.judgmentReadyView = (presented as? JudgmentReadyViewController)?.view as? JudgmentReadyView
    transition.judgmentView = (source as? JudgmentCompletedViewController)?.view as? JudgmentView
    return transition
  }
  
  func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .dismiss
    return transition
  }
}
