//
//  Array+RemovingDuplicates.swift
//  AKCOO
//
//  Created by 박혜운 on 11/16/24.
//

import Foundation

extension Array where Element: Hashable {
  func removingDuplicates() -> [Element] {
    var seen: Set<Element> = []
    return self.filter { element in
      if seen.contains(element) {
        return false
      } else {
        seen.insert(element)
        return true
      }
    }
  }
}
