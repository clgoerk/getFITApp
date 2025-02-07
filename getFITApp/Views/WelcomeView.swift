//
//  WelcomeView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct WelcomeView: View {
  @Binding var showWelcomeView: Bool

  var body: some View {
    VStack {
      Image("getFit")
        .resizable()
        .scaledToFit()
        .frame(maxWidth: 350, maxHeight: 350)
        .padding(.top, 75)
      
      Text("""
           Every Rep Counts
           With getFit
           """)
        .font(.title2)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
      
      Spacer()

      Button(action: {
        showWelcomeView = false
      }) {
        Text("Get Started")
          .font(.headline)
          .padding()
          .frame(maxWidth: 200)
          .background(Color.white)
          .foregroundColor(.black)
          .cornerRadius(10)
      }
      .padding(.bottom, 75)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
    .ignoresSafeArea()
  } // body
} // WelcomeView

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView(showWelcomeView: .constant(true))
  }
} // WelcomeView_Previews
