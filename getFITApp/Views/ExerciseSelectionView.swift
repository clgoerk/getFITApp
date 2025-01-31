//
//  ExerciseSelectionView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct ExerciseSelectionView: View {
  var category: WorkoutCategory
  @Binding var selectedCategory: ExerciseCategory
  
  var body: some View {
    VStack {
      Text("Exercises for \(category.category.rawValue)")
        .font(.title)
        .padding()

      // List exercises for the selected category
      List(category.exercises, id: \.self) { exercise in
        Text(exercise.rawValue)
      }
    }
    .padding()
  }
}

struct ExerciseSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseSelectionView(category: chestExercisesCategory, selectedCategory: .constant(.chest))
  }
}
