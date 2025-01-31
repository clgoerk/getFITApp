//
//  HomeView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-01-31.
//

import SwiftUI

struct HomeView: View {
  @State private var selectedTab = 0
  var body: some View {
    VStack {
      // List catagories
      ForEach(ExerciseCategory.allCases, id: \.self) { category in
        VStack(alignment: .leading) {
          Text(category.rawValue)
            .font(.headline)
            .padding(.top)
        }
        .padding(.bottom)
      }
    }
    .padding()
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

