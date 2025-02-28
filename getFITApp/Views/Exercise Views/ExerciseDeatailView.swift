//
//  ExerciseDeatailView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-19.
//

import SwiftUI

struct ExerciseDetailView: View {
  var exercise: Exercise
  @ObservedObject var workoutStore: WorkoutStore

  @State private var exerciseRows: [ExerciseRow] = []
  @State private var showExerciseInfo = false

  var body: some View {
    VStack {
      ZStack {
        if let gifURL = URL(string: exercise.gifUrl), !exercise.gifUrl.isEmpty {
          GIFWebView(url: gifURL)
            .frame(height: 275)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        } else {
          ProgressView()
            .frame(height: 275)
            .cornerRadius(25)
        }

        GeometryReader { geometry in
          Button(action: { showExerciseInfo.toggle() }) {
            Image(systemName: "info.circle")
              .resizable()
              .scaledToFit()
              .frame(width: 25, height: 25)
              .foregroundColor(.black)
          }
          .position(x: geometry.size.width - 30, y: geometry.size.height - 30)
        }
        .frame(height: 275)
        .padding()
      }

      ScrollView {
        VStack(spacing: 10) {
          ForEach($exerciseRows, id: \.id) { $row in
            ExerciseRowView(exercise: $row)
          }

          // Add New Row
          AddExerciseRowView {
            let newIndex = (exerciseRows.last?.index ?? 0) + 1
            exerciseRows.append(ExerciseRow(id: UUID(), index: newIndex, weight: 50, reps: 10, isCompleted: false))
          }

          // Save Button 
          Button(action: {
            let completedExercise = CompletedExercise(
              exerciseName: exercise.name,
              date: Date(),
              rows: exerciseRows
            )
            workoutStore.saveCompletedExercise(completedExercise)
          }) {
            Text("Save Workout")
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .background(Color.green)
              .cornerRadius(8)
          }
          .padding(.top)
        }
      }
    }
    .background(Color.black)
    .cornerRadius(15)
    .sheet(isPresented: $showExerciseInfo) {
      ExerciseInformation(exercise: exercise)
    }
  } // body
} // ExerciseDetailView

struct ExerciseDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let exercise = Exercise(
      id: UUID().uuidString,
      name: "Push-up",
      bodyPart: "Pectorals",
      equipment: "None",
      target: "Chest",
      gifUrl: "https://example.com/gif-url",
      instructions: ["Start in a plank position.", "Lower your body.", "Push back up."]
    )
    let workoutStore = WorkoutStore()

    ExerciseDetailView(exercise: exercise, workoutStore: workoutStore)
  }
} // ExerciseDetailView_Previews
