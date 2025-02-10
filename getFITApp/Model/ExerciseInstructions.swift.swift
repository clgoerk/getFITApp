//
//  ExerciseInstructions.swift.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-07.
//

import Foundation

extension Exercise {
  var instructions: String {
    
    switch self {
    case .flatBarbellPress:
      return """
      **How to Perform a Flat Barbell Bench Press:**
      1️⃣ Lie on the bench with feet flat on the floor.
      2️⃣ Grip the bar slightly wider than shoulder-width.
      3️⃣ Unrack the bar and lower it to your mid-chest.
      4️⃣ Press the bar back up until arms are fully extended.
      5️⃣ Keep your back slightly arched and maintain control.
      """
    case .inclineBarbellPress:
      return """
      **How to Perform an Incline Barbell Bench Press:**
      1️⃣ Adjust the bench to a 30-45° incline.
      2️⃣ Grip the bar slightly wider than shoulder-width.
      3️⃣ Lower the bar to your upper chest.
      4️⃣ Press the bar back up until arms are fully extended.
      5️⃣ Keep your shoulders engaged and avoid flaring elbows.
      """
    case .squat:
      return """
      **How to Perform a Squat:**
      1️⃣ Stand with feet shoulder-width apart.
      2️⃣ Lower your hips back and down until your thighs are parallel to the ground.
      3️⃣ Keep your chest up and knees aligned with your toes.
      4️⃣ Push through your heels to return to a standing position.
      5️⃣ Engage your core and maintain proper posture.
      """
    default:
      return "Instructions for this exercise will be added soon!"
    }
  }
}
