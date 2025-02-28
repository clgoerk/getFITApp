//
//  ExerciseSelectionView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct ExerciseSelectionView: View {
  @ObservedObject var viewModel: WorkoutViewModel
  @Binding var selectedExercises: [Exercise]
  @Binding var selectedTab: Int
  var selectedBodyPart: String
  
  @State private var searchText: String = ""

  var filteredExercises: [Exercise] {
    viewModel.exercises.filter { $0.bodyPart == selectedBodyPart }
      .filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }
  }

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        Text("Select Exercises")
          .font(.title)
          .foregroundColor(.white)
          .padding(.top)
        
        // Search Bar
        TextField("", text: $searchText, prompt: Text("Search Exercises").foregroundColor(.white.opacity(0.6)))
          .padding(10)
          .background(Color.white.opacity(0.2))
          .cornerRadius(10)
          .foregroundColor(.white) 
          .padding(.horizontal)
        
        ScrollView {
          VStack(spacing: 10) {
            ForEach(filteredExercises, id: \ .id) { exercise in
              Button(action: {
                withAnimation {
                  exerciseSelection(exercise)
                }
              }) {
                HStack {
                  AsyncImage(url: URL(string: exercise.gifUrl)) { phase in
                    switch phase {
                    case .empty: ProgressView().frame(width: 50, height: 50)
                    case .success(let image): image.resizable().scaledToFit().frame(width: 50, height: 50)
                    case .failure: Image(systemName: "photo").resizable().scaledToFit().frame(width: 50, height: 50)
                    @unknown default: EmptyView()
                    }
                  }
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  
                  Text(exercise.name)
                    .font(.body)
                    .foregroundColor(selectedExercises.contains(where: { $0.id == exercise.id }) ? .blue : .white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
              }
              .buttonStyle(.plain)
            }
          }
          .padding(.horizontal)
        }
        
        Spacer()
        
        Button(action: { selectedTab = 2 }) {
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
  } // ExerciseSelectionView
  
  private func exerciseSelection(_ exercise: Exercise) {
    if let index = selectedExercises.firstIndex(where: { $0.id == exercise.id }) {
      selectedExercises.remove(at: index)
    } else {
      selectedExercises.append(exercise)
    }
  }
} // exerciseSelection()

struct ExerciseSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseSelectionView(
      viewModel: WorkoutViewModel(),
      selectedExercises: .constant([]),
      selectedTab: .constant(0),
      selectedBodyPart: "Chest"
    )
  }
} // ExerciseSelectionView_Previews
