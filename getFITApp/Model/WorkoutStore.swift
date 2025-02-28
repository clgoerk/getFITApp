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
  let rows: [ExerciseRow]
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
      completedExercises.removeValue(forKey: exerciseId)
      saveToFile()
      return
    }

    let newSession = CompletedExercise(
      id: UUID(),
      exerciseName: completedExercise.exerciseName,
      date: Date(),
      rows: completedRows
    )

    completedExercises[exerciseId, default: []].insert(newSession, at: 0) // Insert at the top

    saveToFile()
  } // saveCompletedExercises()

  func saveToFile() {
    fileManager.saveToFile(data: completedExercises, filename: filename)
  } // saveToFile()

  func loadFromFile() {
    if let savedData: [String: [CompletedExercise]] = fileManager.loadFromFile(filename: filename) {
      completedExercises = savedData
    }
  } // loadFromFile()
} // WorkoutStore
