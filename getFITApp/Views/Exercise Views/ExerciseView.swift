//
//  ExerciseView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct ExerciseView: View {
  var selectedExercises: [Exercise]
  @ObservedObject var workoutStore: WorkoutStore
  @Binding var selectedTab: Int
  @State private var selectedExerciseId: String?
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        // Make sure an exercise is selected before showing details
        if let selectedExercise = selectedExercises.first(where: { $0.id == selectedExerciseId }) {
          HeaderView(selectedExercise: .constant(selectedExercise))
          
          TabView(selection: $selectedExerciseId) {
            ForEach(selectedExercises, id: \.id) { exercise in
              ExerciseDetailView(
                exercise: exercise,
                workoutStore: workoutStore,
                allExercises: selectedExercises, // Pass all selected exercises
                onSave: { moveToNextExercise() } // Move to the next exercise after saving
              )
              .tag(exercise.id)
            }
          }
          .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
          
          // Workout History Button
          Button(action: {
            selectedTab = 4 // WorkoutHistoryView
          }) {
            Text("View History")
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .background(Color.blue)
              .cornerRadius(8)
          }
          .padding()
        }
      }
      .padding()
      .onAppear {
        selectedExerciseId = selectedExercises.first?.id // Show the first selected exercise
      }
    }
  } // body
  
  private func moveToNextExercise() {
    if let currentIndex = selectedExercises.firstIndex(where: { $0.id == selectedExerciseId }) {
      let nextIndex = currentIndex + 1
      if nextIndex < selectedExercises.count {
        selectedExerciseId = selectedExercises[nextIndex].id
      } else {
        selectedTab = 4 // WorkoutHistoryView
      }
    }
  } // moveToNextExercise()
} // ExerciseView

struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(
      selectedExercises: [
        Exercise(
          id: "1",
          name: "Flat Barbell Bench Press",
          bodyPart: "Chest",
          equipment: "Barbell",
          target: "Pectorals",
          gifUrl: "https://fitnessvolt.com/wp-content/uploads/2023/09/barbell-bench-press.gif",
          instructions: ["Lie flat on a bench", "Grip the barbell", "Lower the bar to your chest", "Push the barbell up"]
        ),
        Exercise(
          id: "2",
          name: "Dumbbell Row",
          bodyPart: "Back",
          equipment: "Dumbbell",
          target: "Lats",
          gifUrl: "https://www.oldschoollabs.com/wp-content/uploads/2020/12/02921301-Dumbbell-Bent-over-Row_back_Back_720.gif",
          instructions: ["Place one knee on a bench", "Hold the dumbbell", "Row the dumbbell towards your torso", "Lower the dumbbell back down"]
        )
      ],
      workoutStore: WorkoutStore(),
      selectedTab: .constant(3)
    )
  }
} // ExerciseView_Previews
