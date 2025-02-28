//
//  ContentView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct ContentView: View {
  @State private var selectedTab = 0
  @State private var showWelcomeView = true
  @State private var selectedBodyPart: String = "Chest"
  @StateObject private var workoutStore = WorkoutStore()
  @StateObject private var viewModel = WorkoutViewModel() 
  @State private var selectedExercise: Exercise? = nil
  
  var body: some View {
    VStack {
      if showWelcomeView {
        WelcomeView(showWelcomeView: $showWelcomeView)
      } else {
        TabView(selection: $selectedTab) {
    
          HomeView(selectedTab: $selectedTab, selectedBodyPart: $selectedBodyPart, viewModel: viewModel)
            .tag(0)

          ExerciseSelectionView(
            viewModel: viewModel,
            selectedExercises: $viewModel.selectedExercises,
            selectedTab: $selectedTab,
            selectedBodyPart: selectedBodyPart
          )
            .tag(1)
          
          WorkoutView(viewModel: viewModel, selectedTab: $selectedTab)
            .tag(2)
            
          ExerciseView(selectedExercises: viewModel.selectedExercises, workoutStore: workoutStore, selectedTab: $selectedTab)
            .tag(3)
          
          WorkoutHistoryView(workoutStore: workoutStore)
            .tag(4)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
      }
    }
    .onAppear {
      print(URL.documentsDirectory)
    }
  } // body
} // ContentView

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
} // ContentView_Previews
