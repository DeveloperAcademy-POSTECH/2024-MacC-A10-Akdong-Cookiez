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
  private var action: Action
  
  enum Action {
    case move
    case moveTextField
    case moveTo(dx: CGFloat, dy: CGFloat)
    case appear
    case disappear
    
    var fromAlpha: CGFloat {
      switch self {
      case .move, .moveTextField, .disappear: return 1
      case .moveTo, .appear: return 0
      }
    }
    
    var toAlpha: CGFloat {
      switch self {
      case .move, .appear, .moveTextField, .disappear: return 0
      case .moveTo: return 1
      }
    }
  }
  
  init(
    from: UIView,
    to: UIView,
    in container: UIView,
    action: Action = .move,
    clipToBounds: Bool = true,
    childTransitions: [(from: UIView, to: UIView, action: Action)] = []
  ) {
    self.fromView = from
    self.toView = to
    self.containerView = container
    self.action = action
    let transitionView = UIView(frame: .zero)
    transitionView.clipsToBounds = clipToBounds
    self.transitionView = transitionView
    self.childTransitions = childTransitions.map {
      SnapshotTransition(from: $0.from, to: $0.to, in: transitionView, action: $0.action, clipToBounds: true)
    }
  }
  
  // 전환 준비 작업
  func prepare() {
    // 시작 뷰와 목표 뷰의 레이어 코너 반경을 저장
    let layerCornerRadiuses = [fromView, toView].map { ($0.layer, $0.layer.cornerRadius) }
    // 시작 뷰와 목표 뷰의 그림자 상태를 저장
    let layerShadows = [fromView, toView].map { $0.layer }.map { ($0, LayerShadow.from($0)) }
    // 자식 전환 뷰들의 알파 값을 저장
    let childAlphas = childTransitions.flatMap { [$0.fromView, $0.toView] }.map { ($0, $0.alpha) }
    
    // 레이어의 코너 반경을 0으로 설정
    layerCornerRadiuses.forEach { layer, _ in layer.cornerRadius = 0 }
    // 그림자를 제거
    layerShadows.forEach { layer, _ in layer.apply(LayerShadow.none) }
    // 자식 전환 뷰들의 알파 값을 0으로 설정
    childAlphas.forEach { view, _ in view.alpha = 0 }
    
    // 시작 뷰와 목표 뷰의 스냅샷 생성
    toSnapshot = toView.snapshotView(afterScreenUpdates: true)
    fromSnapshot = fromView.snapshotView(afterScreenUpdates: true)
    
    // 레이어의 코너 반경을 원래대로 복원
    layerCornerRadiuses.forEach { layer, radius in layer.cornerRadius = radius }
    // 그림자 상태를 원래대로 복원
    layerShadows.forEach { layer, shadow in layer.apply(shadow) }
    // 자식 전환 뷰들의 알파 값을 원래대로 복원
    childAlphas.forEach { view, alpha in view.alpha = alpha }
    
    // 스냅샷을 전환 뷰에 추가하고 크기를 설정
    [fromSnapshot, toSnapshot].compactMap { $0 }.forEach {
      transitionView.addSubview($0)
      $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      $0.frame = transitionView.bounds
    }
    
    // 시작 뷰와 목표 뷰의 알파 값을 저장
    fromViewAlpha = fromView.alpha
    toViewAlpha = toView.alpha
    
    // 스냅샷과 실제 뷰의 알파 값 설정 (스냅샷은 보이고 실제 뷰는 숨김)
    fromSnapshot?.alpha = action.fromAlpha
    toSnapshot?.alpha = action.toAlpha
    fromView.alpha = 0
    toView.alpha = 0
    
    // 전환 뷰의 코너 반경과 그림자 설정, 시작 뷰의 위치와 크기로 초기화
    transitionView.layer.cornerRadius = fromView.layer.cornerRadius
    transitionView.layer.apply(LayerShadow.from(fromView.layer))
    if case .moveTextField = action {
    } else if case .appear = action {
      transitionView.frame = toView.convert(toView.bounds, to: containerView)
    } else {
      transitionView.frame = fromView.convert(fromView.bounds, to: containerView)
    }
    containerView.addSubview(transitionView)
    
    // 자식 전환 준비 작업 실행
    childTransitions.forEach { $0.prepare() }
  }
  
  func addKeyframes() {
    if case .move = action {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8) { [toSnapshot] in
        toSnapshot?.alpha = 1
      }
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) { [fromSnapshot] in
        fromSnapshot?.alpha = 0
      }
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [transitionView, toView] in
        transitionView.layer.cornerRadius = toView.layer.cornerRadius
        transitionView.frame = toView.convert(toView.bounds, to: transitionView.superview)
        transitionView.layer.apply(LayerShadow.from(toView.layer))
      }
    }
    
    if case let .moveTo(dx, dy) = action {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [transitionView] in
        var newFrame = transitionView.frame
        newFrame.origin.x += dx
        newFrame.origin.y += dy
        transitionView.frame = newFrame
      }
    }
    
    if case .appear = action {
      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) { [toSnapshot] in
        toSnapshot?.alpha = 1
      }
      
//      UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2) { [transitionView, toView] in
//        transitionView.layer.cornerRadius = toView.layer.cornerRadius
//        transitionView.frame = toView.convert(toView.bounds, to: transitionView.superview)
//        transitionView.layer.apply(LayerShadow.from(toView.layer))
//      }
    }
    
    if case .disappear = action {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2) { [fromSnapshot] in
        fromSnapshot?.alpha = 0
      }
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [transitionView, toView] in
        var newFrame = transitionView.frame
        newFrame.origin.y = toView.frame.maxY
        transitionView.frame = newFrame
      }
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
