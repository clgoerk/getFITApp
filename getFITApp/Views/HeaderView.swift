//
//  HeaderView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-02.
//

import SwiftUI

struct HeaderView: View {
  var selectedExercise: Exercise 
 
  // Use selected exercise as header
  var body: some View {
    VStack {
      Text(selectedExercise.rawValue)
        .font(.title)
        .foregroundColor(.white)
        .padding()
        .background(Color.black)
    }
  } // body
} // HeaderView

#Preview {
  HeaderView(selectedExercise: .flatBarbellPress)
} // HeaderView_Previews
