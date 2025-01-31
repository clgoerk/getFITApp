//
//  Exercise.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import Foundation

// Workout Category with associated exercises
struct WorkoutCategory {
  let category: ExerciseCategory
  let exercises: [Exercise]
  
  // Initialize with a category and its exercises
  init(category: ExerciseCategory, exercises: [Exercise]) {
    self.category = category
    self.exercises = exercises
  }
}

// Exercise Category Enum
enum ExerciseCategory: String, CaseIterable {
    case chest = "Chest"
    case back = "Back"
    case shoulders = "Shoulders"
    case arms = "Arms"
    case legs = "Legs"
    case abs = "Abs"

    var workoutCategory: WorkoutCategory {
        switch self {
        case .chest:
            return chestExercisesCategory
        case .back:
            return backExercisesCategory
        case .shoulders:
            return shoulderExercisesCategory
        case .arms:
            return armExercisesCategory
        case .legs:
            return legExercisesCategory
        case .abs:
            return absExercisesCategory
        }
    }
}

// Exercise enum for different exercises
enum Exercise: String, CaseIterable{
  // Chest exercises
  case flatBarbellBenchPress = "Flat Barbell Bench Press"
  case inclineBarbellPress = "Incline Barbell Bench Press"
  case declineBarbellPress = "Decline Barbell Press"
  case flatDumbbellPress = "Flat Dumbbell Press"
  case inclineDumbbellPress = "Incline Dumbbell Press"
  case declineDumbbellPress = "Decline Dumbbell Press"
  case dumbbellPullover = "Dumbbell Pullover"
  case chestFly = "Chest Fly"
  
  // Leg exercises
  case legPress = "Leg Press"
  case squat = "Squat"
  case legCurl = "Leg Curl"
  case lunges = "Lunges"
  
  // Shoulder exercises
  case shoulderPress = "Shoulder Press"
  case lateralRaise = "Lateral Raise"
  case frontRaise = "Front Raise"
  case rearDeltoidFly = "Rear Deltoid Fly"
  
  // Back exercises
  case latPulldown = "Lat Pulldown"
  case deadlift = "Deadlift"
  case barbellRow = "Barbell Row"
  case dumbbellRow = "Dumbbell Row"
  
  // Arm exercises
  case bicepCurl = "Bicep Curl"
  case tricepExtension = "Tricep Extension"
  case hammerCurl = "Hammer Curl"
  case preacherCurl = "Preacher Curl"
  
  // Abs exercises
  case crunch = "Crunch"
  case legRaise = "Leg Raise"
  case plank = "Plank"
  case bicycleCrunch = "Bicycle Crunch"
  
  // Exercise images
  var imageName: String {
    switch self {
    case .flatBarbellBenchPress:
      return "Bench"
    case .inclineBarbellPress:
      return "IBBP"
    default:
      return ""
    }
  }
}

// Category arrays
let chestExercises: [Exercise] = [
  .flatBarbellBenchPress,
  .inclineBarbellPress,
  .declineBarbellPress,
  .flatDumbbellPress,
  .inclineDumbbellPress,
  .declineDumbbellPress,
  .dumbbellPullover,
  .chestFly
]

let armExercises: [Exercise] = [
  .bicepCurl,
  .tricepExtension,
  .hammerCurl,
  .preacherCurl
]

let legExercises: [Exercise] = [
  .legPress,
  .squat,
  .legCurl,
  .lunges
]

let shoulderExercises: [Exercise] = [
  .shoulderPress,
  .lateralRaise,
  .frontRaise,
  .rearDeltoidFly
]

let backExercises: [Exercise] = [
  .latPulldown,
  .deadlift,
  .barbellRow,
  .dumbbellRow
]

let absExercises: [Exercise] = [
  .crunch,
  .legRaise,
  .plank,
  .bicycleCrunch
]

// Example ExerciseCategoryStruct for each category
let chestExercisesCategory = WorkoutCategory(category: .chest, exercises: chestExercises)
let armExercisesCategory = WorkoutCategory(category: .arms, exercises: armExercises)
let legExercisesCategory = WorkoutCategory(category: .legs, exercises: legExercises)
let shoulderExercisesCategory = WorkoutCategory(category: .shoulders, exercises: shoulderExercises)
let backExercisesCategory = WorkoutCategory(category: .back, exercises: backExercises)
let absExercisesCategory = WorkoutCategory(category: .abs, exercises: absExercises)
