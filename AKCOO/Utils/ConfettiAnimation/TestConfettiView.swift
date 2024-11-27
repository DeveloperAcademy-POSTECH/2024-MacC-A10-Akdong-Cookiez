//
//  TestConfettiView.swift
//  AKCOO
//
//  Created by Anjin on 11/27/24.
//

import SwiftUI

struct TestConfettiView: View {
  @State var counter = 0
  
  var body: some View {
    ZStack {
      Color(red: 0.21, green: 0.52, blue: 0.85)
        .ignoresSafeArea()
      
      Text("🎉").onTapGesture {
        counter += 1
      }
      
      /* Default */
      ConfettiView(
        imageName: "Omark"
      )
    }
  }
}

#Preview {
  TestConfettiView()
}
