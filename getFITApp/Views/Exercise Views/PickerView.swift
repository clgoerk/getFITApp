//
//  PickerView.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-07.
//

import SwiftUI

struct PickerView: View {
  var label: String
  @Binding var selection: Int
  var range: Range<Int>
  var step: Int

  var body: some View {
    Picker(label, selection: $selection) {
      ForEach(range, id: \.self) { value in
        if value % step == 0 {
          Text("\(value) \(label)")
            .foregroundColor(.white)
        }
      }
    }
    .pickerStyle(WheelPickerStyle())
    .frame(height: 120)
    .clipped()
    .colorScheme(.dark)
  }
} // PickerView

struct PickerView_Previews: PreviewProvider {
  static var previews: some View {
    PickerView(label: "Weight", selection: .constant(50), range: 0..<501, step: 5)
      .padding()
      .background(Color.black)
  }
} // PickerView_Previews
