//
//  HeaderView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-02.
//

import SwiftUI

struct HeaderView: View {
  @Binding var selectedExercise: Exercise?

  var body: some View {
    VStack {
      if let exercise = selectedExercise {
        Text(exercise.name)
          .font(.title)
          .foregroundColor(.white)
         
          .background(Color.black)
      } else {
        Text("Select an Exercise")
          .font(.title)
          .foregroundColor(.gray)
          .padding()
          .background(Color.black)
      }
    }
  } // body
} // HeaderView

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HeaderView(selectedExercise: .constant(Exercise(
      id: "1",
      name: "Flat Barbell Press",
      bodyPart: "Chest",
      equipment: "Barbell",
      target: "Pectorals",
      gifUrl: "",
      instructions: [""]
    )))
  }
} // HeaderView_Previews
