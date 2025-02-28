//
//  HomeView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct HomeView: View {
  @Binding var selectedTab: Int
  @Binding var selectedBodyPart: String
  @ObservedObject var viewModel: WorkoutViewModel
  @State private var isLoading: Bool = false

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      VStack {
        Text("Let's plan your workout!")
          .font(.title)
          .padding()
          .foregroundColor(.white)
        
        ScrollView {
          VStack(spacing: 10) {
            // Populate list with body part catagories
            ForEach(viewModel.bodyParts, id: \.self) { bodyPart in
              Button(action: {
                selectedBodyPart = bodyPart
                selectedTab = 1
              }) {
                Text(bodyPart.capitalized)
                  .font(.headline)
                  .padding()
                  .frame(maxWidth: .infinity)
                  .background(Color.gray.opacity(0.2))
                  .foregroundColor(.white)
                  .cornerRadius(10)
              }
            }
          }
          .padding(.horizontal)
        }

        Spacer()

        // Refresh Button to manually call API pull
        Button(action: {
          isLoading = true
          Task {
            await viewModel.refreshExercises()
            isLoading = false
          }
        }) {
          HStack {
            if isLoading {
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
            Text(isLoading ? "Refreshing..." : "Refresh Exercises")
          }
          .font(.headline)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(10)
        }
        .padding()
      }
      .padding()
      .onAppear {
        viewModel.loadExercises() // load body parts catagories
      }
    }
  } // body
} // HomeView

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(selectedTab: .constant(0), selectedBodyPart: .constant("Chest"), viewModel: WorkoutViewModel())
  }
} // HomeView_Previews
