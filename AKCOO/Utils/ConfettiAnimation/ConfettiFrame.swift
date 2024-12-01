//
//  ConfettiFrame.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI

struct ConfettiFrame: View {
  @ObservedObject var confettiVM: ConfettiCenterVM
  @State var location: CGPoint = CGPoint(x: 0, y: 0)
  @State var opacity: Double = 0.0
  
  var body: some View {
    ConfettiItem(shape: getShape(), color: getColor())
      .offset(x: location.x, y: location.y)
      .opacity(opacity)
      .onAppear {
        withAnimation(Animation.timingCurve(0.1, 1.0, 0, 1, duration: getAnimationDuration())) {
          opacity = confettiVM.opacity
          
          let randomAngle: CGFloat
          if confettiVM.openingAngle.degrees <= confettiVM.closingAngle.degrees {
            randomAngle = CGFloat.random(in: CGFloat(confettiVM.openingAngle.degrees)...CGFloat(confettiVM.closingAngle.degrees))
          } else {
            randomAngle = CGFloat.random(in: CGFloat(confettiVM.openingAngle.degrees)...CGFloat(confettiVM.closingAngle.degrees + 360)).truncatingRemainder(dividingBy: 360)
          }
          
          let distance = getDistance()
          
          location.x = distance * cos(deg2rad(randomAngle))
          location.y = -distance * sin(deg2rad(randomAngle))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + getDelayBeforeDropAnimation()) {
          withAnimation(Animation.timingCurve(0.12, 0, 0.39, 0, duration: confettiVM.dropAnimationDuration)) {
            location.y += confettiVM.dropHeight
            opacity = confettiVM.fadesOut ? 0 : confettiVM.opacity
          }
        }
      }
  }
  
  func getShape() -> AnyView {
    return confettiVM.getShapes().randomElement()!
  }
  
  func getColor() -> Color {
    return confettiVM.colors.randomElement()!
  }
  
  func getRandomExplosionTimeVariation() -> CGFloat {
    return CGFloat((0...999).randomElement()!) / 2100
  }
  
  func getAnimationDuration() -> CGFloat {
    return 0.2 + confettiVM.explosionAnimationDuration + getRandomExplosionTimeVariation()
  }
  
  func getDistance() -> CGFloat {
    if !confettiVM.fireworkEffect {
      return pow(CGFloat.random(in: 0.01...1), 2.0 / 7.0) * confettiVM.radius
    }
    return confettiVM.radius
  }
  
  func getDelayBeforeDropAnimation() -> TimeInterval {
    confettiVM.explosionAnimationDuration *  0.1
  }
  
  func deg2rad(_ number: CGFloat) -> CGFloat {
    return number * CGFloat.pi / 180
  }
}
