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
  @State private var selectedCategory: ExerciseCategory = .chest
  @State private var selectedExercises: [Exercise] = []

  var body: some View {
    VStack {
      if showWelcomeView {
        WelcomeView(showWelcomeView: $showWelcomeView)
      } else {
        TabView(selection: $selectedTab) {
    
          HomeView(selectedTab: $selectedTab, selectedCategory: $selectedCategory)
            .tag(0)

          ExerciseSelectionView(category: selectedCategory, categoryExercises: selectedCategory.exercises, selectedExercises: $selectedExercises, selectedTab: $selectedTab)
            .tag(1)

          ExerciseView(selectedExercises: selectedExercises)
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
      }
    } // if
  } // body
} // ContentView

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
} // ContentView_Previews
