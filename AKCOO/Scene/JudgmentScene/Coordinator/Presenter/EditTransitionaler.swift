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
    transition.judgmentView = (source as? JudgmentCompletedViewController)?.view as? JudgmentView
    transition.judgmentEditView = (presented as? JudgmentEditViewController)?.view as? JudgmentEditView
    return transition
  }
  
  func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .dismiss
    return transition
  }
}
