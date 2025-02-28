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
        // If an exercise is selected display its details
        if let selectedExercise = selectedExercises.first(where: { $0.id == selectedExerciseId }) {
          HeaderView(selectedExercise: .constant(selectedExercise))
          
          TabView(selection: $selectedExerciseId) {
            // Loop through the exercises and create a tab for each selected exercise
            ForEach(selectedExercises, id: \.id) { exercise in
              ExerciseDetailView(exercise: exercise, workoutStore: workoutStore)
                .tag(exercise.id)
            }
          }
          .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

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
        selectedExerciseId = selectedExercises.first?.id
      }
    }
  } // body
} // ExerciseView

// Preview for the ExerciseView, showing sample exercises
struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(
      selectedExercises: [
        Exercise(
          id: "1",
          name: "Flat Barbell Press",
          bodyPart: "Chest",
          equipment: "Barbell",
          target: "Pectorals",
          gifUrl: "https://example.com/image.gif",
          instructions: ["Lie flat on a bench", "Grip the barbell", "Lower the bar to your chest", "Push the barbell up"]
        ),
        Exercise(
          id: "2",
          name: "Dumbbell Row",
          bodyPart: "Back",
          equipment: "Dumbbell",
          target: "Lats",
          gifUrl: "https://example.com/image2.gif",
          instructions: ["Place one knee on a bench", "Hold the dumbbell", "Row the dumbbell towards your torso", "Lower the dumbbell back down"]
        )
      ],
      workoutStore: WorkoutStore(),
      selectedTab: .constant(3) 
    )
  }
} // ExerciseView_Previews
