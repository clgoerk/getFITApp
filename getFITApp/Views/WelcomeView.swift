//
//  WelcomeView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct WelcomeView: View {
  @Binding var selectedTab: Int
  
  var body: some View {
    VStack {
      Text("Welcome!")
        .font(.title)
        .padding()
      
      Button(action: {
        selectedTab = 0
      }) {
        Text("Get Started")
          .font(.title2)
          .foregroundColor(.blue)
      }
    }
  }
}

#Preview {
  WelcomeView(selectedTab: .constant(9))
}
