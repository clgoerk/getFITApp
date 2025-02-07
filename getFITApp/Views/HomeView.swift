//
//  HomeView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct HomeView: View {
  @Binding var selectedTab: Int
  @Binding var selectedCategory: ExerciseCategory

  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      
      VStack {
        
        Text("Lets plan your workout!")
          .font(.title)
          .padding()
          .foregroundColor(.white)
        
        // List exercise catagories as buttons
        ForEach(ExerciseCategory.allCases, id: \.self) { category in
          Button(action: {
            selectedCategory = category
            selectedTab = 1 // 
          }) {
            Text(category.rawValue)
              .font(.headline)
              .padding()
              .frame(maxWidth: .infinity)
              .background(Color.gray.opacity(0.2))
              .foregroundColor(.white)
              .cornerRadius(10)
          }
          .padding(.bottom)
        }
      }
      .padding()
    }
  } // body
} // HomeView

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(selectedTab: .constant(0), selectedCategory: .constant(.chest))
  }
} // HomeView_Previews
