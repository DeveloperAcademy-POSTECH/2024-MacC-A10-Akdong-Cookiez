//
//  String+fillTemplate.swift
//  AKCOO
//
//  Created by Anjin on 12/1/24.
//

import Foundation

extension String {
  func fillTemplate(with content: String) -> String {
    return String(format: self, content)
  }
}
