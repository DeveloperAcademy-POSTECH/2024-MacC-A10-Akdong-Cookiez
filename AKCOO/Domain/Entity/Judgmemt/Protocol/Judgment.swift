//
//  Judgment.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import Foundation

protocol Judgment {
  associatedtype Standards
  var userAmount: Double { get set }
  var standards: Standards { get set }
  var result: JudgmentType { get }
}