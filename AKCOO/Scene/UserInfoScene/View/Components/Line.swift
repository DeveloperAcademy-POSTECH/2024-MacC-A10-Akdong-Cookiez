//
//  Line.swift
//  AKCOO
//
//  Created by Anjin on 12/2/24.
//

import SwiftUI

struct Line: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX, y: rect.midY)) // 시작점
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) // 끝점
    return path
  }
}
