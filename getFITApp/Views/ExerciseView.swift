//
//  ExerciseView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct ExerciseView: View {
  var exercise: Exercise
  @Binding var selectedTab: Int  
  
  var body: some View {
    VStack {
      Text(exercise.rawValue)
        .font(.title2)
        .padding()
      }
    }
  }


struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(exercise: .flatBarbellBenchPress, selectedTab: .constant(9))
  }
}
