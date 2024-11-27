//
//  ConfettiCenterVM.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI

class ConfettiCenterVM: ObservableObject {
  /// - Parameters:
  ///  - counter: on any change of this variable the animation is run
  ///  - num: amount of confettis
  ///  - colors: list of colors that is applied to the default shapes
  ///  - confettiSize: size that confettis and emojis are scaled to
  ///  - dropHeight: vertical distance that confettis pass
  ///  - fadesOut: reduce opacity towards the end of the animation
  ///  - fireworkEffect: every item will explosive in same circle line
  ///  - opacity: maximum opacity that is reached during the animation
  ///  - openingAngle: boundary that defines the opening angle in degrees
  ///  - closingAngle: boundary that defines the closing angle in degrees
  ///  - radius: explosion radius
  ///  - repetitions: number of repetitions of the explosion
  ///  - repetitionInterval: duration between the repetitions
  @Published var confettiNumber: Int
  @Published var confettiTypes: [ConfettiType]
  @Published var colors: [Color]
  @Published var confettiSize: CGFloat
  @Published var dropHeight: CGFloat
  @Published var fadesOut: Bool
  @Published var fireworkEffect: Bool
  @Published var opacity: Double
  @Published var openingAngle: Angle
  @Published var closingAngle: Angle
  @Published var radius: CGFloat
  @Published var repetitions: Int
  @Published var repetitionInterval: Double
  @Published var explosionAnimationDuration: Double
  @Published var dropAnimationDuration: Double
  
  init(
    confettiNumber: Int = 20,
    confettiTypes: [ConfettiType] = [ConfettiType.image(imageName: "Xmark")],
    //         colors: [Color] = [.random(), .random(), .random(), .random(),.random(), .random(), .random()],
    colors: [Color] = [Color.red, Color.blue, .orange],
    confettiSize: CGFloat = 15.0,
    dropHeight: CGFloat = 600.0,
    fadesOut: Bool = true,
    fireworkEffect: Bool = false,
    opacity: Double = 1.0,
    openingAngle: Angle = .degrees(20),
    closingAngle: Angle = .degrees(160),
    radius: CGFloat = 140,
    repetitions: Int = 0,
    repetitionInterval: Double = 1.0,
    explosionAnimDuration: Double = 0.2,
    dropAnimationDuration: Double = 3.5
  ) {
    self.confettiNumber = confettiNumber
    self.confettiTypes = confettiTypes
    self.colors = colors
    self.confettiSize = confettiSize
    self.dropHeight = dropHeight
    self.fadesOut = fadesOut
    self.fireworkEffect = fireworkEffect
    self.opacity = opacity
    self.openingAngle = openingAngle
    self.closingAngle = closingAngle
    self.radius = radius
    self.repetitions = repetitions
    self.repetitionInterval = repetitionInterval
    self.explosionAnimationDuration = explosionAnimDuration
    self.dropAnimationDuration = dropAnimationDuration
  }
  
  func getShapes() -> [AnyView] {
    var shapes = [AnyView]()
    for confetti in confettiTypes {
      for color in colors {
        switch confetti {
        case .shape:
          shapes.append(
            AnyView(
              confetti.view.foregroundColor(color)
                .frame(
                  width: confettiSize,
                  height: confettiSize,
                  alignment: .center
                )
            )
          )
        default:
          shapes.append(
            AnyView(
              confetti.view.foregroundColor(color).font(.system(size: confettiSize))
                .frame(
                  width: confettiSize,
                  height: confettiSize,
                  alignment: .center
                )
            )
          )
        }
      }
    }
    return shapes
  }
  
  func getAnimDuration() -> CGFloat {
    return explosionAnimationDuration + dropAnimationDuration
  }
}
