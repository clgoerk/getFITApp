//
//  SelectedExercisesView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-09.
//

import SwiftUI

struct WorkoutView: View {
  @ObservedObject var viewModel: WorkoutViewModel
  @Binding var selectedTab: Int

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        ScrollView {
          VStack {
            Text("Todays Workout")
              .foregroundColor(.white)
              .font(.title)
              .padding(.bottom, 10)

            if viewModel.selectedExercises.isEmpty {
              Text("No exercises selected")
                .foregroundColor(.gray)
                .padding()
            } else {
              ForEach(viewModel.selectedExercises, id: \.id) { exercise in
                HStack {
                  AsyncImage(url: URL(string: exercise.gifUrl)) { phase in
                    switch phase {
                    case .empty:
                      ProgressView().frame(width: 50, height: 50)
                    case .success(let image):
                      image.resizable().scaledToFit().frame(width: 50, height: 50)
                    case .failure:
                      Image(systemName: "photo").resizable().scaledToFit().frame(width: 50, height: 50)
                    @unknown default:
                      EmptyView()
                    }
                  }
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  
                  Text(exercise.name)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
              }
            }
          }
          .padding()
        }

        Button(action: {
          selectedTab = 3 // ExerciseView
        }) {
          Text("Start your Workout")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(viewModel.selectedExercises.isEmpty ? Color.gray : Color.blue)
            .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
        .disabled(viewModel.selectedExercises.isEmpty) // Prevents navigation if no exercises are selected
      }
    }
  } // body
} // WorkoutView

struct WorkoutView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutView(
      viewModel: WorkoutViewModel(),
      selectedTab: .constant(0)
    )
  }
} // WorkoutView_Previews
