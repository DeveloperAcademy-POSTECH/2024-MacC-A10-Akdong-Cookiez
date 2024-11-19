//
//  SnapshotTransition.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import UIKit

class SnapshotTransition {
  private let fromView: UIView
  private let toView: UIView
  private let containerView: UIView
  private let transitionView: UIView
  private let childTransitions: [SnapshotTransition]
  private var fromViewAlpha: CGFloat = 1
  private var toViewAlpha: CGFloat = 1
  private var fromSnapshot: UIView?
  private var toSnapshot: UIView?
  
  init(
    from: UIView,
    to: UIView,
    in container: UIView,
    clipToBounds: Bool = true,
    childTransitions: [(from: UIView, to: UIView)] = []
  ) {
    self.fromView = from
    self.toView = to
    self.containerView = container
    let transitionView = UIView(frame: .zero)
    transitionView.clipsToBounds = clipToBounds
    self.transitionView = transitionView
    self.childTransitions = childTransitions.map {
      SnapshotTransition(from: $0.from, to: $0.to, in: transitionView, clipToBounds: false)
    }
  }
  
  func prepare() {
    let layerCornerRadiuses = [fromView, toView].map { ($0.layer, $0.layer.cornerRadius) }
    let layerShadows = [fromView, toView].map { $0.layer }.map { ($0, LayerShadow.from($0)) }
    let childAlphas = childTransitions.flatMap { [$0.fromView, $0.toView] }.map { ($0, $0.alpha) }
    
    layerCornerRadiuses.forEach { layer, _ in layer.cornerRadius = 0 }
    layerShadows.forEach { layer, _ in layer.apply(LayerShadow.none) }
    childAlphas.forEach { view, _ in view.alpha = 0 }
    
    toSnapshot = toView.snapshotView(afterScreenUpdates: true)
    fromSnapshot = fromView.snapshotView(afterScreenUpdates: true)
    
    layerCornerRadiuses.forEach { layer, radius in layer.cornerRadius = radius }
    layerShadows.forEach { layer, shadow in layer.apply(shadow) }
    childAlphas.forEach { view, alpha in view.alpha = alpha }
    
    [fromSnapshot, toSnapshot].compactMap { $0 }.forEach {
      transitionView.addSubview($0)
      $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      $0.frame = transitionView.bounds
    }
    
    fromViewAlpha = fromView.alpha
    toViewAlpha = toView.alpha
    
    fromSnapshot?.alpha = 1
    toSnapshot?.alpha = 0
    fromView.alpha = 0
    toView.alpha = 0
    
    transitionView.layer.cornerRadius = fromView.layer.cornerRadius
    transitionView.layer.apply(LayerShadow.from(fromView.layer))
    transitionView.frame = fromView.convert(fromView.bounds, to: containerView)
    containerView.addSubview(transitionView)
    
    childTransitions.forEach { $0.prepare() }
  }
  
  func addKeyframes() {
    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) { [toSnapshot] in
      toSnapshot?.alpha = 1
    }
    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) { [fromSnapshot] in
      fromSnapshot?.alpha = 0
    }
    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [transitionView, toView] in
      transitionView.layer.cornerRadius = toView.layer.cornerRadius
      transitionView.frame = toView.convert(toView.bounds, to: transitionView.superview)
      transitionView.layer.apply(LayerShadow.from(toView.layer))
    }
    
    childTransitions.forEach { $0.addKeyframes() }
  }
  
  func cleanUp() {
    toView.alpha = toViewAlpha
    fromView.alpha = fromViewAlpha
    transitionView.removeFromSuperview()
    fromSnapshot?.removeFromSuperview()
    toSnapshot?.removeFromSuperview()
    fromSnapshot = nil
    toSnapshot = nil
    
    childTransitions.forEach { $0.cleanUp() }
  }
}
