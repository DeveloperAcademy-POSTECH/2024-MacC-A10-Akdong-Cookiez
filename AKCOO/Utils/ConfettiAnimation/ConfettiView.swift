//
//  ConfettiView.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI

struct ConfettiView: View {
  @State var counter: Int = 0
  @StateObject var confettiVM = ConfettiCenterVM()
  @State var animate = 0
  @State var finishedAnimationCounter = 0
  @State var firstAppear = false
  
  init(imageName: String?) {
//    self._counter = counter
    
    self._confettiVM = StateObject(wrappedValue: ConfettiCenterVM(
      confettiNumber: 20,
      confettiTypes: [ConfettiType.image(imageName: imageName ?? "greenbird")],
      confettiSize: 15.0,
      dropHeight: 600.0,
      fireworkEffect: false,
      openingAngle: .degrees(20),
      closingAngle: .degrees(160),
      radius: 140,
      repetitions: 0,
      repetitionInterval: 1.0,
      explosionAnimDuration: 0.2,
      dropAnimationDuration: 3.5
    ))
  }
  
  var body: some View {
    ZStack {
      ForEach(finishedAnimationCounter..<animate, id: \.self) { _ in
        ConfettiContainer(
          confettiVM: confettiVM,
          finishedAnimationCounter: $finishedAnimationCounter
        )
      }
    }
    .onAppear {
      firstAppear = true
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        animate += 1
      }
    }
    .onChange(of: counter) { _, _ in
      if firstAppear {
        for index in 0...confettiVM.repetitions {
          DispatchQueue.main.asyncAfter(deadline: .now() + confettiVM.repetitionInterval * Double(index)) {
            animate += 1
          }
        }
      }
      
      print("aaa")
    }
  }
}

#Preview {
  TestConfettiView()
}
