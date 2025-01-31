//
//  ContentView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct ContentView: View {
  @State private var selectedTab = 9
  @State private var selectedCategory: ExerciseCategory = .chest

  var body: some View {
    TabView(selection: $selectedTab) {
      
      WelcomeView(selectedTab: $selectedTab)
        .tag(9)
  
      HomeView()
        .tag(0)
      
      ExerciseSelectionView(category: selectedCategory.workoutCategory, selectedCategory: $selectedCategory)
        .tag(1)
      
      // Excercise subviews
      ForEach(Exercise.allCases.indices, id: \.self) { index in
        ExerciseView(exercise: Exercise.allCases[index], selectedTab: $selectedTab)
          .tag(index)
      }
    }
    .tabViewStyle(PageTabViewStyle())
    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
