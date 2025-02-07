//
//  Exercise.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import Foundation

struct Workout {
  let category: String
  let exercises: [Exercise]
}
// Exercise Categories
enum ExerciseCategory: String, CaseIterable {
  case chest = "Chest"
  case back = "Back"
  case shoulders = "Shoulders"
  case arms = "Arms"
  case legs = "Legs"
  case abs = "Abs"

  // Exercises based on the category
  var exercises: [Exercise] {
    switch self {
    case .chest:
      return [
        .flatBarbellPress,
        .inclineBarbellPress,
        .declineBarbellPress,
        .flatDumbbellPress,
        .inclineDumbbellPress,
        .declineDumbbellPress,
        .dumbbellPullover,
        .chestFly
      ]
    case .back:
      return [
        .latPulldown,
        .deadlift,
        .barbellRow,
        .dumbbellRow
      ]
    case .shoulders:
      return [
        .shoulderPress,
        .lateralRaise,
        .frontRaise,
        .rearDeltoidFly
      ]
    case .arms:
      return [
        .bicepCurl,
        .tricepExtension,
        .hammerCurl,
        .preacherCurl
      ]
    case .legs:
      return [
        .legPress,
        .squat,
        .legCurl,
        .lunges
      ]
    case .abs:
      return [
        .crunch,
        .legRaise,
        .plank,
        .bicycleCrunch
      ]
    }
  }
} // Workout

enum Exercise: String, CaseIterable {
  // Chest Exercises
  case flatBarbellPress = "Flat Barbell Press"
  case inclineBarbellPress = "Incline Barbell Press"
  case declineBarbellPress = "Decline Barbell Press"
  case flatDumbbellPress = "Flat Dumbbell Press"
  case inclineDumbbellPress = "Incline Dumbbell Press"
  case declineDumbbellPress = "Decline Dumbbell Press"
  case dumbbellPullover = "Dumbbell Pullover"
  case chestFly = "Chest Fly"
  
  // Leg Exercises
  case legPress = "Leg Press"
  case squat = "Squat"
  case legCurl = "Leg Curl"
  case lunges = "Lunges"
  
  // Shoulder Exercises
  case shoulderPress = "Shoulder Press"
  case lateralRaise = "Lateral Raise"
  case frontRaise = "Front Raise"
  case rearDeltoidFly = "Rear Deltoid Fly"
  
  // Back Exercises
  case latPulldown = "Lat Pulldown"
  case deadlift = "Deadlift"
  case barbellRow = "Barbell Row"
  case dumbbellRow = "Dumbbell Row"
  
  // Arm Exercises
  case bicepCurl = "Bicep Curl"
  case tricepExtension = "Tricep Extension"
  case hammerCurl = "Hammer Curl"
  case preacherCurl = "Preacher Curl"
  
  // Abs Exercises
  case crunch = "Crunch"
  case legRaise = "Leg Raise"
  case plank = "Plank"
  case bicycleCrunch = "Bicycle Crunch"
  
  // Exercise images
  var imageName: String {
    switch self {
    case .flatBarbellPress:
      return "FBBP"
    case .inclineBarbellPress:
      return "IBBP"
    default:
      return ""
    }
  }
} // Exercise

let chestExercises = ExerciseCategory.chest.exercises
let armExercises = ExerciseCategory.arms.exercises
let legExercises = ExerciseCategory.legs.exercises
let shoulderExercises = ExerciseCategory.shoulders.exercises
let backExercises = ExerciseCategory.back.exercises
let absExercises = ExerciseCategory.abs.exercises

let chestWorkout = Workout(category: "Chest", exercises: chestExercises)
let armWorkout = Workout(category: "Arms", exercises: armExercises)
let legWorkout = Workout(category: "Legs", exercises: legExercises)
let shoulderWorkout = Workout(category: "Shoulders", exercises: shoulderExercises)
let backWorkout = Workout(category: "Back", exercises: backExercises)
let absWorkout = Workout(category: "Abs", exercises: absExercises)


