//
//  ExerciseAPIService.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-19.
// 

import Foundation

class ExerciseAPIService {
  private let apiKey = "91ef78fe02msh4ef3366c47cc325p17ea8ejsnebfcc37c70ac"
  private let apiHost = "exercisedb.p.rapidapi.com"
  
  func fetchExercises() async throws -> [Exercise] {
    let urlString = "https://exercisedb.p.rapidapi.com/exercises?limit=0&offset=0"
    return try await fetchFromAPI(urlString: urlString)
  } // fetchExercises()
  
  func fetchBodyParts() async throws -> [String] {
    let urlString = "https://exercisedb.p.rapidapi.com/exercises/bodyPartList"
    guard let url = URL(string: urlString) else { throw URLError(.badURL) }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
    request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw URLError(.badServerResponse)
    }
    
    return try JSONDecoder().decode([String].self, from: data)
  } // fetchBodyParts()
  
  private func fetchFromAPI(urlString: String) async throws -> [Exercise] {
    guard let url = URL(string: urlString) else {
      throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
    request.setValue(apiHost, forHTTPHeaderField: "x-rapidapi-host")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      throw URLError(.badServerResponse)
    }
    
    var exercises = try JSONDecoder().decode([Exercise].self, from: data)
    
    // Capitalize first letter of each word in exercise names
    for index in exercises.indices {
      exercises[index].name = capitalizeTitle(exercises[index].name)
    }
    
    return exercises
  } // fetchFromAPI()
  
  // Capitalize first letter of every word
  private func capitalizeTitle(_ string: String) -> String {
    let exceptions = ["and", "or", "the", "in", "on", "a", "an", "for", "with", "to", "by"]
    let words = string.split(separator: " ").map { word -> String in
      if exceptions.contains(word.lowercased()) {
        return word.lowercased()
      } else {
        return word.capitalized
      }
    }
    return words.joined(separator: " ")
  } // capitalizeTitle
} // ExerciseAPIService
