//
//  TweetInfo.swift
//  AKCOO
//
//  Created by 박혜운 on 11/15/24.
//

import Foundation

protocol CountryCriterion {
  var category: String { get }
  var title: String { get }
  var amount: String { get }
}

protocol Tweet {
  var name: String { get }
  var infomation: String { get }
}

protocol CountryTweet: Tweet {
  
}
