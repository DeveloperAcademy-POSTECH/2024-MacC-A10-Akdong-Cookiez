//
//  String+FormatWithComma.swift
//  AKCOO
//
//  Created by 박혜운 on 11/23/24.
//

import Foundation

extension String {
  func formatWithComma() -> String? {
    guard let number = Double(self) else { return nil }
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal // 천 단위 구분자 추가
    formatter.maximumFractionDigits = 2 // 소수점 이하 자릿수 최대 2자리로 제한 (필요 시 조정)
    
    return formatter.string(from: NSNumber(value: number))
  }
}

extension String {
  func removingCommas() -> String {
    return self.replacingOccurrences(of: ",", with: "")
  }
}
