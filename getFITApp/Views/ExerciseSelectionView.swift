//
//  ExerciseSelectionView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct ExerciseSelectionView: View {
  var category: ExerciseCategory // Store selected category
  var categoryExercises: [Exercise]
  @Binding var selectedExercises: [Exercise]
  @Binding var selectedTab: Int
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      
      VStack {
        // Display category
        Text("Select \(category.rawValue) Exercises")
          .font(.title)
          .foregroundColor(.white) // Ensure text is visible
          .padding()
        
        ScrollView {
          VStack(spacing: 10) {
            ForEach(categoryExercises, id: \.self) { exercise in
              Button(action: {
                withAnimation {
                  exerciseSelection(exercise)
                }
              }) {
                HStack {
                  // Placeholder for possible image
                  Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
                    .padding(.leading)

                  Text(exercise.rawValue)
                    .font(.body)
                    .foregroundColor(selectedExercises.contains(exercise) ? .blue : .white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
              }
              .buttonStyle(.plain) // Ensures it behaves like a simple tap
            }
          }
          .padding(.horizontal)
        }
        
        Spacer()
        
        // Start Workout button
        Button(action: {
          selectedTab = 2
        }) {
          Text("View Your Workout")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(selectedExercises.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(10)
        }
        .padding()
        .disabled(selectedExercises.isEmpty)
      }
      .padding()
    }
  }
  
  // Add or remove exercises from selection
  private func exerciseSelection(_ exercise: Exercise) {
    if let index = selectedExercises.firstIndex(of: exercise) {
      selectedExercises.remove(at: index)
    } else {
      selectedExercises.append(exercise)
    }
  }
}

struct ExerciseSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseSelectionView(
      category: .chest,
      categoryExercises: ExerciseCategory.chest.exercises,
      selectedExercises: .constant([.flatBarbellPress]),
      selectedTab: .constant(0)
    )
  }
} // ExerciseSelectionView_Previews
