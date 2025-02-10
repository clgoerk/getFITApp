//
//  SelectedExercisesView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-09.
//

import SwiftUI

struct WorkoutView: View {
  var selectedExercises: [Exercise]
  @Binding var selectedTab: Int

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        ScrollView {
          VStack {
            Text("Selected Exercises")
              .foregroundColor(.white)
              .font(.title)
              .padding(.bottom, 10)

            ForEach(ExerciseCategory.allCases, id: \.self) { category in
              let categoryExercises = selectedExercises.filter { category.exercises.contains($0) }
              
              if !categoryExercises.isEmpty {
                Text("\(category.rawValue) Exercises")
                  .font(.headline)
                  .foregroundColor(.white)
                  .padding(.top, 10)
                  .frame(maxWidth: .infinity, alignment: .center)
                
                
                ForEach(categoryExercises, id: \.self) { exercise in
                  HStack {
                    // Placeholder for possile image
                    Image(systemName: "photo")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 50, height: 50)
                      .foregroundColor(.gray)
                      .padding(.leading)

                    Text(exercise.rawValue)
                      .font(.body)
                      .foregroundColor(.white)
                      .padding()
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .background(Color.gray.opacity(0.2))
                      .cornerRadius(10)
                  }
                } // for
              }
            } // for
          }
          .padding()
        }

        Button(action: {
          selectedTab = 3
        }) {
          Text("Start your Workout")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
      }
    }
  } // body
} // WorkoutView

struct WorkoutView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutView(
      selectedExercises: [
        .flatBarbellPress,
        .squat,
        .latPulldown,
        .bicepCurl
      ],
      selectedTab: .constant(0)
    )
  }
} // WorkoutView_Previews
