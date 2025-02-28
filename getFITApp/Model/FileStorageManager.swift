//
//  FileStorageManager.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-23.
//

import Foundation

class FileStorageManager {
  private let exercisesFile = "exercises.json"
  private let historyFile = "workout_history.json"
  
  func saveExercisesToFile(_ exercises: [Exercise]) {
    saveToFile(data: exercises, filename: exercisesFile)
  } // saveExercisesToFile()
  
  func loadExercisesFromFile() -> [Exercise]? {
    return loadFromFile(filename: exercisesFile)
  } // loadExercisesFromFile()
  
  func saveWorkoutHistoryToFile(_ history: [String: [CompletedExercise]]) {
    saveToFile(data: history, filename: historyFile)
  } // saveWorkoutHistoryToFile()
  
  func loadWorkoutHistoryFromFile() -> [String: [CompletedExercise]]? {
    return loadFromFile(filename: historyFile)
  } // loadWorkoutHistoryFromFile()
  
  func saveToFile<T: Codable>(data: T, filename: String) {
    let url = getDocumentsDirectory().appendingPathComponent(filename)
    do {
      let encodedData = try JSONEncoder().encode(data)
      try encodedData.write(to: url)
      print("✅ \(filename) saved successfully.")
    } catch {
      print("❌ Failed to save \(filename): \(error)")
    }
  } // saveToFile()
  
  func loadFromFile<T: Codable>(filename: String) -> T? {
    let url = getDocumentsDirectory().appendingPathComponent(filename)
    guard FileManager.default.fileExists(atPath: url.path) else { return nil }
    
    do {
      let data = try Data(contentsOf: url)
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      print("⚠️ Failed to load \(filename): \(error)")
      return nil
    }
  } // loadFromFile()
  
  func removeFile(filename: String) {
    let url = getDocumentsDirectory().appendingPathComponent(filename)
    do {
      if FileManager.default.fileExists(atPath: url.path) {
        try FileManager.default.removeItem(at: url)
        print("✅ \(filename) deleted successfully.")
      } else {
        print("❌ \(filename) not found.")
      }
    } catch {
      print("❌ Failed to delete \(filename): \(error)")
    }
  } // removeFile()
  
  private func getDocumentsDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  } // getDocumentsDirectory()
} // FileStoreManager
