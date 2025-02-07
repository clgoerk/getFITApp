//
//  AddExerciseRowView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-07.
//

import SwiftUI

struct AddExerciseRowView: View {
  var onAddExercise: () -> Void

  var body: some View {
    HStack {
      Text("  +")
        .frame(width: 30, alignment: .leading)
        .font(.title)
        .foregroundColor(.blue)

      Spacer()

      Text("Add Set")
        .foregroundColor(.white)

      Spacer()
    }
    .padding(.vertical, 8)
    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
    .onTapGesture {
      onAddExercise()
    }
  } // body
} // AddExerciseRowView

struct AddExerciseRowView_Previews: PreviewProvider {
  static var previews: some View {
    AddExerciseRowView {
      print("Add Exercise tapped!")
    }
    .background(Color.black)
    .previewLayout(.sizeThatFits)
  }
} // AddExerciseRowView_Previews
