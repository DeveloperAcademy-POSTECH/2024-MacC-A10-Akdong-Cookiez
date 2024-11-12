//
//  ExpenseSceneTransitioningDelegater.swift
//  AKCOO
//
//  Created by 박혜운 on 11/10/24.
//

import UIKit

class ExpenseSceneTransitioningDelegater: NSObject, UIViewControllerTransitioningDelegate {
  private let transition = ExpenseSceneTransition()
  var selectedIndexPath: IndexPath?
  
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .present
    if
      let travelListController = source as? TravelListSceneController,
      let indexPath = selectedIndexPath {
      transition.cellView = travelListController.travelTableView.cellForRow(at: indexPath) as? TravelTableViewCell
    } else {
      transition.cellView = nil
    }

    transition.contentView = (presented as? ExpenseSceneController)?.view
    print(transition.cellView, transition.contentView)
    
    return transition
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .dismiss
    return transition
  }
}
