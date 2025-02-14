//
//  DateExtension.swift
//  getFITApp
//
//  Created by Chris Goerk on 2025-02-14.
//

import Foundation

extension Date {
  // Returns a formatted string of the date
  func formattedString(format: String = "MMM d, yyyy") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: self)
  }

  // Returns the start of the day for the date
  var startOfDay: Date {
    return Calendar.current.startOfDay(for: self)
  }

  // Returns the number of days between two dates
  func daysBetween(_ otherDate: Date) -> Int {
    let components = Calendar.current.dateComponents([.day], from: self, to: otherDate)
    return components.day ?? 0
  }

  // Returns a date by adding a given number of days
  func addingDays(_ days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
  }

  // Checks if the date is today
  var isToday: Bool {
    return Calendar.current.isDateInToday(self)
  }
} // Date
