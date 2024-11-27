//
//  ConfettiView.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI

struct ConfettiView: View {
  @ObservedObject var viewModel: CounterViewModel
  @StateObject var confettiVM = ConfettiCenterVM()
  @State var animate = 0
  @State var finishedAnimationCounter = 0
  @State var firstAppear = false
  
  init(viewModel: CounterViewModel, isLeft: Bool, imageName: String?) {
    self.viewModel = viewModel
    self._confettiVM = StateObject(wrappedValue: ConfettiCenterVM(
      confettiNumber: 70,
      confettiTypes: [ConfettiType.image(imageName: imageName ?? "greenbird")],
      confettiSize: 23.0,
      dropHeight: 600.0,
      fireworkEffect: false,
      openingAngle: .degrees(isLeft ? 60 : 40),
      closingAngle: .degrees(isLeft ? 140 : 120),
      radius: 600,
      repetitions: 0,
      repetitionInterval: 1.0,
      explosionAnimDuration: 0.6,
      dropAnimationDuration: 2.0
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
    }
    .onChange(of: viewModel.counter) { _, _ in
      if firstAppear {
        for index in 0...confettiVM.repetitions {
          DispatchQueue.main.asyncAfter(deadline: .now() + confettiVM.repetitionInterval * Double(index)) {
            animate += 1
          }
        }
      }
    }
  }
}
