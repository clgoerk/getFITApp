//
//  ExerciseRowView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-07.
//

import SwiftUI

struct ExerciseRowView: View {
  @Binding var exercise: ExerciseRow

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("\(exercise.index).")
          .frame(width: 30, alignment: .leading)

        Spacer()

        Text("\(exercise.weight) lbs")
          .frame(width: 80)
          .onTapGesture { exercise.isEditing.toggle() }
        
        Spacer()
        
        Text("\(exercise.reps) reps")
          .frame(width: 80)
          .onTapGesture { exercise.isEditing.toggle() }

        Spacer()

        Button(action: { exercise.isCompleted.toggle() }) {
          Image(systemName: exercise.isCompleted ? "checkmark.circle.fill" : "circle")
            .foregroundColor(exercise.isCompleted ? .green : .gray)
        }
      }
      .padding(.vertical, 4)
      .foregroundColor(.white)

      if exercise.isEditing {
        HStack(spacing: 16) {
          PickerView(label: "lbs", selection: $exercise.weight, range: 0..<501, step: 5)
          PickerView(label: "reps", selection: $exercise.reps, range: 1..<51, step: 1)
        }
      } // if
    }
    .padding()
    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
  } // body
} // ExerciseRowView

struct ExerciseRow: Identifiable, Codable {
  var id = UUID()
  var index: Int
  var weight: Int = 50
  var reps: Int = 8
  var isCompleted: Bool
  var isEditing: Bool = false
} // ExerciseRow

struct ExerciseRowView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseRowView(exercise: .constant(ExerciseRow(index: 1, weight: 50, reps: 8, isCompleted: false)))
      .background(Color.black)
      .edgesIgnoringSafeArea(.all)
      .previewLayout(.sizeThatFits)
  }
} // ExerciseRowView_Previews
