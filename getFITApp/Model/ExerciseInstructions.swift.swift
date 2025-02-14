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
      - Lie on the bench with feet flat on the floor.
      - Grip the bar slightly wider than shoulder-width.
      - Unrack the bar and lower it to your mid-chest.
      - Press the bar back up until arms are fully extended.
      - Keep your back slightly arched and maintain control.
      """
    case .inclineBarbellPress:
      return """
      **How to Perform an Incline Barbell Bench Press:**
      - Adjust the bench to a 30-45° incline.
      - Grip the bar slightly wider than shoulder-width.
      - Lower the bar to your upper chest.
      - Press the bar back up until arms are fully extended.
      - Keep your shoulders engaged and avoid flaring elbows.
      """
    case .squat:
      return """
      **How to Perform a Squat:**
      - Stand with feet shoulder-width apart.
      - Lower your hips back and down until your thighs are parallel to the ground.
      - Keep your chest up and knees aligned with your toes.
      - Push through your heels to return to a standing position.
      - Engage your core and maintain proper posture.
      """
    default:
      return "Instructions for this exercise will be added soon!"
    }
  }
}
