//
//  ConfettiItem.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI

struct ConfettiItem: View {
  @State var shape: AnyView
  @State var color: Color
  
  @State var move = false
  @State var anchor = CGFloat(Int.random(in: 0...1))
  @State var spinDirX = [-1.0, 1.0].randomElement()!
  @State var spinDirZ = [-1.0, 1.0].randomElement()!
  @State var xSpeed = Double.random(in: 0.501...2.201)
  @State var zSpeed = Double.random(in: 0.501...2.201)
  
  var body: some View {
    shape
      .foregroundColor(color)
      .rotation3DEffect(.degrees(move ? 360:0), axis: (x: spinDirX, y: 0, z: 0))
      .animation(Animation.linear(duration: xSpeed).repeatForever(), value: move)
      .rotation3DEffect(.degrees(move ? 360:0), axis: (x: 0, y: 0, z: spinDirZ), anchor: UnitPoint(x: anchor, y: anchor))
      .animation(Animation.linear(duration: zSpeed).repeatForever(), value: move)
      .onAppear { move = true }
  }
}
