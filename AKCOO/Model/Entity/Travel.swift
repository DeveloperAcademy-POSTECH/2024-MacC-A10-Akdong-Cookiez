//
//  Travel.swift
//  AKCOO
//
//  Created by 박혜운 on 11/7/24.
//

import Foundation

struct Travel: Identifiable {
  let id: String = UUID.init().uuidString
  var flag: String
  var country: String
  var currency: Currency
  var startDate: Date
  var endDate: Date
  var budget: Budget
  
  func dayTravel(on targetDate: Date) -> Int? {
    let calendar = Calendar.current
    let startDate = calendar.startOfDay(for: self.startDate)
    let targetDate = calendar.startOfDay(for: targetDate)

    guard let dayDifference = calendar.dateComponents([.day], from: startDate, to: targetDate).day else { return nil }

    // 첫날은 1일 차이므로 +1
    return dayDifference+1
  }
}
