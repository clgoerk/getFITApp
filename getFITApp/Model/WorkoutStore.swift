//
//  WorkoutStore.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-09.
//

import Foundation

struct CompletedExercise: Identifiable {
  let id = UUID()
  let rows: [ExerciseRow]  
}

class WorkoutStore: ObservableObject {
  @Published var selectedExercises: [Exercise] = []
  @Published var completedExercises: [Exercise: [CompletedExercise]] = [:]
  
  func addExercise(_ exercise: Exercise) {
    if !selectedExercises.contains(exercise) {
      selectedExercises.append(exercise)
    }
  } // addExercise()
  
  func removeExercise(_ exercise: Exercise) {
    selectedExercises.removeAll { $0 == exercise }
  } // removeExercise()
  
  func saveCompletedExercises(for exercise: Exercise, rows: [ExerciseRow]) {
    let completedRows = rows.filter { $0.isCompleted }
    
    if completedRows.isEmpty { return } 
    
    var existingEntries = completedExercises[exercise, default: []]

    let newRows = completedRows.filter { newRow in
      !existingEntries.contains { $0.rows.contains { $0.index == newRow.index } }
    }

    if !newRows.isEmpty {
      existingEntries.append(CompletedExercise(rows: newRows))
      completedExercises[exercise] = existingEntries
    }
  } // saveCompletedExercises()
} // WorkoutStore
