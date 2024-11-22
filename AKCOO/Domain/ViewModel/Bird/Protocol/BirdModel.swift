//
//  TweetBird.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

/// 새가 되기 위한 조건
protocol BirdModel {
  var name: String { get }
  var information: String { get }
  var opinion: String { get }
  var detail: String { get }
  var judgment: Bool { get }
}
