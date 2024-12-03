//
//  BirdConstants.swift
//  AKCOO
//
//  Created by Anjin on 12/1/24.
//

import Foundation

struct BirdConstants {
  struct ForeignBirdOpinion {
    static let strongYesWith숙소식당카페: String = "뭘 고민해! 무조건 가야지"
    static let strongYes: String = "뭘 고민해! 무조건 소비해"
    static let mediumYes: String = "이 가격이면 나쁘지 않아"
    static let weakYes: String = "현지에서도 저렴한 가격이야"
    static let weakNo: String = "음.. 조금 비싼데!?"
    static let mediumNo: String = "음.. 꽤 비싼 편이야"
    
    // 사용 시, 카테고리 문자열 추가 필요
    static let strongNoWithCategory: String = "너무 비싸! 다른 %@ 찾아봐"
    static let strongNo: String = "너무 비싸! 다른 걸 찾아봐"
  }
  
  struct LocalBirdOpinion {
    static let strongYes: String = "한국에서는 볼 수 없는 가격이야"
    static let mediumYes: String = "한국에서도 저렴한 가격이야"
    static let weakYes: String = "한국이랑 비슷한 편이야"
    static let weakNo: String = "한국보다 조금 비싼 편이야"
    
    // 사용 시, 카테고리 문자열 추가 필요
    static let mediumNoWithCategory: String = "차라리 한국에서 %@ 어때?"
    static let mediumNo: String = "차라리 한국에서 소비해"
    
    // 사용 시, 카테고리 문자열 추가 필요
    static let strongNoWithCategory: String = "너무 비싸! 다른 %@ 찾아봐"
    static let strongNo: String = "너무 비싸! 다른 걸 찾아봐"
  }
}
