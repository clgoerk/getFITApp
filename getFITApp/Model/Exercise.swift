//
//  Exercise.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import Foundation

struct Exercise: Identifiable, Codable, Hashable {
  let id: String
  var name: String
  let bodyPart: String
  let equipment: String
  let target: String
  let gifUrl: String
  let instructions: [String]
} // Exercise


