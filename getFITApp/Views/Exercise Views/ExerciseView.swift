//
//  ExerciseView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct ExerciseView: View {
  var selectedExercises: [Exercise]
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
                  // Display exercise rows
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
          } // for
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

        Button(action: {
      
        }) {
          Text("View History")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding(.bottom)
      }
      .padding()
      .onAppear {
        // Default to the first selected exercise
        if let firstExercise = selectedExercises.first {
          selectedExercise = firstExercise
        }
      }
    }
  } // body
} // ExerciseView

struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(selectedExercises: [Exercise.flatBarbellPress, Exercise.dumbbellRow])
  }
} // ExerciseView_Previews
