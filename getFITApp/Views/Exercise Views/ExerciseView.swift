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
  @State private var selectedExercise: Exercise = .flatBarbellPress
  @State private var exercises: [ExerciseRow] = []

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      VStack {
        HeaderView(selectedExercise: selectedExercise)

        TabView(selection: $selectedExercise) {
          ForEach(selectedExercises, id: \.self) { exercise in
            VStack {
              Image(exercise.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.bottom, 20)

              ScrollView {
                VStack {
                  ForEach($exercises) { $exerciseRow in
                    ExerciseRowView(exercise: $exerciseRow)
                  }

                  AddExerciseRowView {
                    let newIndex = (exercises.last?.index ?? 0) + 1
                    exercises.append(ExerciseRow(index: newIndex, isCompleted: false))
                  }
                }
              }
              Spacer()
            }
            .tag(exercise)
          }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onChange(of: selectedExercise) {
          exercises = []
        }

        Button(action: {
          workoutStore.saveCompletedExercises(for: selectedExercise, rows: exercises)
        }) {
          Text("Save Completed Sets")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(8)
        }
        .padding(.bottom, 10)

        Button(action: {
          selectedTab = 4
        }) {
          Text("View History")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding(.bottom, 10)
      }
      .padding()
      .onAppear {
        if let firstExercise = selectedExercises.first {
          selectedExercise = firstExercise
        }
      }
    }
  }
}

struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(
      selectedExercises: [Exercise.flatBarbellPress, Exercise.dumbbellRow],
      workoutStore: WorkoutStore(),
      selectedTab: .constant(3)
    )
  }
}
