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
        // Title
        Text("Today's Workout")
          .foregroundColor(.white)
          .font(.title)
          .padding(.bottom, 10)

        // Display message if no exercises are selected
        if viewModel.selectedExercises.isEmpty {
          Text("No exercises selected")
            .foregroundColor(.gray)
            .padding()
        } else {
          VStack {
            List {
              ForEach(viewModel.selectedExercises, id: \.id) { exercise in
                HStack {
                  // Load exercise GIF
                  AsyncImage(url: URL(string: exercise.gifUrl)) { phase in
                    switch phase {
                    case .empty:
                      ProgressView()
                        .frame(width: 50, height: 50)
                    case .success(let image):
                      image.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    case .failure:
                      Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    @unknown default:
                      EmptyView()
                    }
                  }
                  .clipShape(RoundedRectangle(cornerRadius: 10))

                  // Exercise Name
                  Text(exercise.name)
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 5)
                // Swipe to remove exercise
                .swipeActions {
                  Button(role: .destructive) {
                    withAnimation {
                      viewModel.removeExercise(exercise)
                    }
                  } label: {
                    Label("Delete", systemImage: "trash")
                  }
                }
                .listRowBackground(Color.clear)
              }
            }
            .listStyle(PlainListStyle())
          }
          .padding(.horizontal)
        }
        Spacer()

        // Start Workout Button
        Button(action: {
          if !viewModel.selectedExercises.isEmpty {
            selectedTab = 3 // ExerciseView
          }
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
        .disabled(viewModel.selectedExercises.isEmpty) // Disable if no exercises selected
      }
      .padding(.top, 20) 
    }
    .gesture(
      DragGesture()
        .onEnded { value in
          if value.translation.width < -100 {
            // Block left swipe
          } else if value.translation.width > 100 {
            // Allow right swipe
            selectedTab = max(selectedTab - 1, 0)
          }
        }
    )
  }
}


struct WorkoutView_Previews: PreviewProvider {
  static var previews: some View {
    WorkoutView(
      viewModel: WorkoutViewModel(),
      selectedTab: .constant(0)
    )
  }
} // WorkoutView_Previews
