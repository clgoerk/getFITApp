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
  var allExercises: [Exercise] 
  var onSave: () -> Void
  
  @State private var exerciseRows: [ExerciseRow] = []
  @State private var showExerciseInfo = false
  @State private var showAlert = false
  
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
        // information icon
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

      TabDots(filteredExercises: allExercises)
      
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
          
          // Save & Next Button
          Button(action: {
            let completedExercise = CompletedExercise(
              exerciseName: exercise.name,
              date: Date(),
              rows: exerciseRows
            )
            workoutStore.saveCompletedExercise(completedExercise)
            showAlert = true // Show alert after saving
          }) {
            Text("Save & Next")
              .font(.headline)
              .foregroundColor(.white)
              .padding()
              .background(Color.green)
              .cornerRadius(8)
          }
          .padding(.top)
          .alert(isPresented: $showAlert) {
            Alert(
              title: Text("Workout Saved"),
              message: Text("\(exercise.name) has been saved!"),
              dismissButton: .default(Text("OK"), action: {
                onSave()
              })
            )
          }
        }
      }
    }
    .background(Color.black)
    .cornerRadius(15)
    .sheet(isPresented: $showExerciseInfo) {
      ExerciseInformation(exercise: exercise)
    }
  } // body
  
  private func TabDots(filteredExercises: [Exercise]) -> some View {
    HStack(spacing: 8) {
      ForEach(filteredExercises, id: \.id) { currentExercise in
        RoundedRectangle(cornerRadius: 4)
          .fill(exercise.id == currentExercise.id ? Color.blue : Color.gray)
          .frame(width: 20, height: 10)
      }
    }
    .padding(.bottom, 10)
  } // TabDots()
} // ExerciseDetailView

struct ExerciseDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseDetailView(
      exercise: Exercise(
        id: "1",
        name: "Push-up",
        bodyPart: "Pectorals",
        equipment: "None",
        target: "Chest",
        gifUrl: "https://homeworkouts.org/wp-content/uploads/anim-push-ups.gif",
        instructions: ["Start in a plank position.", "Lower your body.", "Push back up."]
      ),
      workoutStore: WorkoutStore(),
      allExercises: [],
      onSave: {}
    )
  }
} // ExerciseDetailView_Previews
