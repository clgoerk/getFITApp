//
//  WorkoutHistoryView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-09.
//

import SwiftUI

struct WorkoutHistoryView: View {
  @ObservedObject var workoutStore: WorkoutStore
  var selectedExercises: [Exercise]
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      VStack {
        Text("Workout History")
          .font(.largeTitle)
          .foregroundColor(.white)
          .padding()

        ScrollView {
          // Go through each selected exercise and show saved sets if available
          ForEach(selectedExercises, id: \.self) { exercise in
            VStack(alignment: .leading, spacing: 2) {
              Text(exercise.rawValue)
                .font(.title3)
                .foregroundColor(.white)
                .padding(.vertical, 5)
              
              // Check if this exercise has any saved sets
              if let completedExercise = workoutStore.completedExercises[exercise] {
                ForEach(completedExercise, id: \.id) { entry in
                  // Display all the sets for that exercise
                  ForEach(entry.rows, id: \.index) { row in
                    HStack {
                      Text("Set \(row.index):")
                        .foregroundColor(.white)
                        .padding(.trailing, 10)

                      Text("\(row.weight) lbs for \(row.reps) reps")
                        .foregroundColor(.white)
                      Spacer()
                    }
                    .padding(.vertical, 1)
                  } // for
                } // for
              } else {
                Text("No history for this exercise.")
                  .foregroundColor(.white)
                  .italic()
              }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
          } // for
        }
      }
    }
  } // body
} // WorkoutHistoryView

struct WorkoutHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    let workoutStore = WorkoutStore()
    workoutStore.completedExercises = [
      .flatBarbellPress: [
        CompletedExercise(rows: [
          ExerciseRow(index: 1, weight: 185, reps: 8, isCompleted: true),
          ExerciseRow(index: 2, weight: 190, reps: 6, isCompleted: false)
        ])
      ]
    ]
    return WorkoutHistoryView(workoutStore: workoutStore, selectedExercises: [.flatBarbellPress])
  }
} // WorkoutHistoryView_Previews
