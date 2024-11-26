//
//  Date+toCompactKoreanDateString.swift
//  AKCOO
//
//  Created by Anjin on 11/26/24.
//

import Foundation

extension Date {
  /// "yy년 MM월 dd일" 형식으로 Date를 포맷팅
  func toCompactKoreanDateString() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yy년 MM월 dd일"
    return formatter.string(from: self)
  }
}
