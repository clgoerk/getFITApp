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
          let dates = getWorkoutDates()

          ForEach(dates, id: \.self) { date in
            VStack(alignment: .leading, spacing: 5) {
              Text(date.formattedString())
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 5)

              // Loop through selected exercises and display history
              ForEach(selectedExercises, id: \.self) { exercise in
                let exercisesForDate = workoutStore.completedExercises[exercise]?.filter { $0.date.startOfDay == date } ?? []
                
                if !exercisesForDate.isEmpty {
                  Text(exercise.rawValue)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.vertical, 5)

                  ForEach(exercisesForDate, id: \.id) { completedExercise in
                    ForEach(completedExercise.rows, id: \.index) { row in
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
                } // if
              } // for
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
          } // for
        }
      }
    }
  } // body

  // Helper function to get unique sorted workout dates
  private func getWorkoutDates() -> [Date] {
    let allDates = workoutStore.completedExercises.values.flatMap { $0.map { $0.date.startOfDay } }
    return Array(Set(allDates)).sorted(by: >)
  } // getWorkoutDates()
} // WorkoutHistoryView

struct WorkoutHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    let workoutStore = WorkoutStore()
    workoutStore.completedExercises = [
      .flatBarbellPress: [
        CompletedExercise(date: Date(), rows: [
          ExerciseRow(index: 1, weight: 185, reps: 8, isCompleted: true),
          ExerciseRow(index: 2, weight: 190, reps: 6, isCompleted: false)
        ])
      ]
    ]
    return WorkoutHistoryView(workoutStore: workoutStore, selectedExercises: [.flatBarbellPress])
  }
} // WorkoutHistoryView_Previews
