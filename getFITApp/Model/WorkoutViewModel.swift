//
//  WorkoutViewModel.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-19.
//

import SwiftUI

class WorkoutViewModel: ObservableObject {
  @Published var exercises: [Exercise] = []
  @Published var selectedExercises: [Exercise] = []
  @Published var searchText: String = ""
  @Published var selectedBodyPart: String = "All"
  
  private let apiService = ExerciseAPIService()
  private let fileManager = FileStorageManager()
  
  var bodyParts: [String] {
    let parts = Set(exercises.map { $0.bodyPart })
    return parts.sorted()
  }
  
  func loadExercises() {
    if let savedExercises = fileManager.loadExercisesFromFile(), !savedExercises.isEmpty {
      exercises = savedExercises
    } else {
      Task {
        await fetchAndSaveExercises() // Fetch from API if no local data
      }
    }
  } // loadExercises
  
  func fetchAndSaveExercises() async {
    do {
      let fetchedExercises = try await apiService.fetchExercises()
      DispatchQueue.main.async {
        self.exercises = fetchedExercises
        self.fileManager.saveExercisesToFile(fetchedExercises) // Save API data
      }
    } catch {
      print("❌ Failed to fetch exercises: \(error)")
    }
  } // fetchAndSaveExercises()
  
  func refreshExercises() async {
    do {
      let fetchedExercises = try await apiService.fetchExercises()
      DispatchQueue.main.async {
        self.exercises = fetchedExercises
        self.fileManager.saveExercisesToFile(fetchedExercises) // Save new data
      }
    } catch {
      print("❌ Failed to refresh exercises: \(error)")
    }
  } // refreshExercises()
  
  func removeExercise(_ exercise: Exercise) {
    selectedExercises.removeAll { $0.id == exercise.id }
  } // removeExercise()
} // WorkoutViewModel

