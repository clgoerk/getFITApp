//
//  ExerciseInformation.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-20.
//

import SwiftUI

struct ExerciseInformation: View {
  let exercise: Exercise

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        if let gifURL = URL(string: exercise.gifUrl) {
          GIFWebView(url: gifURL)
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
        } else {
          Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .foregroundColor(.gray)
        }

        Text(exercise.name)
          .font(.largeTitle)
          .fontWeight(.bold)
          .foregroundColor(.white)

        Text("Target: \(exercise.target)")
          .font(.title2)
          .foregroundColor(.blue)

        Text("Equipment: \(exercise.equipment)")
          .font(.body)
          .foregroundColor(.white)

        Divider()
          .background(Color.white)

        if !exercise.instructions.isEmpty {
          Text("Instructions:")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
          ForEach(exercise.instructions, id: \.self) { step in
            Text("• \(step)")
              .font(.body)
              .foregroundColor(.white)
              .padding(.bottom, 2)
          }
        }

        Spacer()
      }
      .padding()
    }
    .background(Color.black.ignoresSafeArea())
    .navigationTitle(exercise.name)
    .foregroundColor(.white)
  }
} // ExerciseInformation

#Preview {
  ExerciseInformation(exercise: Exercise(
    id: "1",
    name: "Push-up",
    bodyPart: "Chest",
    equipment: "Body weight",
    target: "Pectorals",
    gifUrl: "https://example.com/image.gif",
    instructions: ["Start in a plank position.", "Lower your body.", "Push back up."]
  ))
} // ExerciseInformation_Previews
