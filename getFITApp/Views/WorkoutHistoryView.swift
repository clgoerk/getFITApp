//
//  WorkoutHistoryView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-09.
//

import SwiftUI

struct WorkoutHistoryView: View {
  @ObservedObject var workoutStore: WorkoutStore
  private let fileStorageManager = FileStorageManager()
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        // Header title
        Text("Workout History")
          .font(.largeTitle)
          .foregroundColor(.white)
          .padding()
        
        ScrollView {
          // Flattening all completed exercises into a single array
          let allCompletedExercises = workoutStore.completedExercises.values.flatMap { $0 }
          
          // Group exercises by their completion date
          let groupedByDate = Dictionary(grouping: allCompletedExercises) { $0.date.startOfDay }
          
          // Sort dates in descending order
          let sortedDates = groupedByDate.keys.sorted(by: >)
          
          // Display each date and its corresponding exercises
          ForEach(sortedDates, id: \.self) { date in
            VStack(alignment: .leading, spacing: 8) {
              Text(date.formattedString())
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.vertical, 5)
              
              // List all exercises completed on this date
              if let exercisesForDate = groupedByDate[date] {
                ForEach(exercisesForDate) { entry in
                  VStack(alignment: .leading, spacing: 8) {
                    Text(entry.exerciseName)
                      .font(.title3)
                      .foregroundColor(.white)
                      .padding(.vertical, 5)
                    
                    // List of sets with weight and reps
                    ForEach(entry.rows) { row in
                      HStack {
                        Text("Set \(row.index):")
                          .foregroundColor(.white)
                          .padding(.trailing, 10)
                        
                        Text("\(row.weight) lbs for \(row.reps) reps")
                          .foregroundColor(.white)
                        
                        Spacer()
                      }
                      .padding(.vertical, 1)
                    }
                  }
                  .padding(.horizontal)
                  .padding(.bottom, 10)
                }
              }
            }
            .padding(.bottom, 20)
          }
        }
        
        // Clear History Button
        Button(action: clearHistory) {
          Text("Clear History")
            .font(.headline)
            .foregroundColor(.red)
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(8)
        }
        .padding(.top)
      }
    } // ZStack
  } // body
  
  private func clearHistory() {
    workoutStore.completedExercises.removeAll()
    fileStorageManager.removeFile(filename: "workout_history.json")
  } // clearHistory()
} // WorkoutHistoryView

struct WorkoutHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    let workoutStore = WorkoutStore()
    workoutStore.completedExercises = [
      "1": [
        CompletedExercise(
          exerciseName: "Flat Barbell Press",
          date: Date(),
          rows: [
            ExerciseRow(index: 1, weight: 185, reps: 8, isCompleted: true),
            ExerciseRow(index: 2, weight: 190, reps: 6, isCompleted: true)
          ]
        )
      ]
    ]

    return WorkoutHistoryView(workoutStore: workoutStore)
  }
} // WorkoutHistoryView_Previews
