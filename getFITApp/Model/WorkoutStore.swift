//
//  WorkoutStore.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-09.
//

import Foundation

struct CompletedExercise: Identifiable, Codable {
  var id: UUID = UUID()
  let exerciseName: String
  let date: Date
  var rows: [ExerciseRow]
} // CompletedExercise

class WorkoutStore: ObservableObject {
  @Published var selectedExercises: [Exercise] = []
  @Published var completedExercises: [String: [CompletedExercise]] = [:]

  private let fileManager = FileStorageManager()
  private let filename = "workout_history.json"

  init() {
    loadFromFile()
  } // init()

  func addExercise(_ exercise: Exercise) {
    if !selectedExercises.contains(where: { $0.id == exercise.id }) {
      selectedExercises.append(exercise)
    }
  } // addExercise()

  func removeExercise(_ exercise: Exercise) {
    selectedExercises.removeAll { $0.id == exercise.id }
  } // removeExercise()

  func saveCompletedExercise(_ completedExercise: CompletedExercise) {
    let exerciseId = completedExercise.exerciseName
    let completedRows = completedExercise.rows.filter { $0.isCompleted }

    guard !completedRows.isEmpty else {
      // If no sets are completed remove the exercise from history
      completedExercises.removeValue(forKey: exerciseId)
      saveToFile()
      return
    }
    if var existingSessions = completedExercises[exerciseId] {
      // Check if there is an existing session for today
      if let todayIndex = existingSessions.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: Date()) }) {
        // Merge new sets with existing session for today
        var updatedSession = existingSessions[todayIndex]
        updatedSession.rows = completedRows // Update with new sets
        existingSessions[todayIndex] = updatedSession
      } else {
        // No session for today so create a new one
        let newSession = CompletedExercise(
          id: UUID(),
          exerciseName: completedExercise.exerciseName,
          date: Date(),
          rows: completedRows
        )
        existingSessions.insert(newSession, at: 0) // Insert at the top
      }
      completedExercises[exerciseId] = existingSessions
    } else {
      // If no previous sessions exist create a new one
      completedExercises[exerciseId] = [
        CompletedExercise(
          id: UUID(),
          exerciseName: completedExercise.exerciseName,
          date: Date(),
          rows: completedRows
        )
      ]
    }
    saveToFile() // Save updates
  } // saveCompletedExercise()

  func saveToFile() {
    fileManager.saveToFile(data: completedExercises, filename: filename)
  } // saveToFile()

  func loadFromFile() {
    if let savedData: [String: [CompletedExercise]] = fileManager.loadFromFile(filename: filename) {
      completedExercises = savedData
    }
  } // loadFromFile()
} // WorkoutStore
