//
//  ConfettiType.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI

enum ConfettiType: CaseIterable, Hashable {
  enum Shape {
    case circle
    case triangle
    case square
    case slimRectangle
    case roundedCross
  }
  
  case shape(Shape)
  case text(String)
  case sfSymbol(symbolName: String)
  case image(imageName: String)
  
  var view: AnyView {
    switch self {
    case .shape(.square):
      return AnyView(Rectangle())
    case .shape(.triangle):
      return AnyView(Triangle())
    case .shape(.slimRectangle):
      return AnyView(SlimRectangle())
    case .shape(.roundedCross):
      return AnyView(RoundedCross())
    case let .text(text):
      return AnyView(Text(text))
    case .sfSymbol(let symbolName):
      return AnyView(Image(systemName: symbolName))
    case .image(let imageName):
      return AnyView(
        Image(imageName)
          .resizable()
          .scaledToFit()
      )
    default:
      return AnyView(Circle())
    }
  }
  
  static var allCases: [ConfettiType] {
    return [
      .shape(.circle),
      .shape(.triangle),
      .shape(.square),
      .shape(.slimRectangle),
      .shape(.roundedCross)
    ]
  }
}
