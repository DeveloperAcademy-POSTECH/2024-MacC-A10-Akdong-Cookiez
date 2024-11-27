//
//  ConfettiContainer.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI

struct ConfettiContainer: View {
  @ObservedObject var confettiVM: ConfettiCenterVM
  @Binding var finishedAnimationCounter: Int
  @State var firstAppear = true
  
  var body: some View {
    ZStack {
      ForEach(0 ..< confettiVM.confettiNumber, id: \.self) { _ in
        ConfettiFrame(confettiVM: confettiVM)
      }
    }
    .onAppear {
      if firstAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + confettiVM.getAnimDuration()) {
          self.finishedAnimationCounter += 1
        }
        firstAppear = false
      }
    }
  }
}
