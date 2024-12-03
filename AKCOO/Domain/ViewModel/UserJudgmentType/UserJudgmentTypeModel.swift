//
//  UserJudgmentTypeModel.swift
//  AKCOO
//
//  Created by Anjin on 12/2/24.
//

import Foundation

/// 사용자 판단 유형을 보이기 위해 화면에 필요한 값
struct UserJudgmentTypeModel {
  var userRecords: [UserRecord]
  
  private var selectedCountry: CountryProfile? {
    return self.userRecords.first?.userQuestion.country
  }
  
  var userBirdType: UserJudgmentType {
    guard let selectedCountry else { return .empty }
    
    switch userBirdTypeName {
    case "\(selectedCountry.name) 10년차":
      return .foreign(selectedCountry)
    case "한국 토박이":
      let korea = CountryProfile(name: "대한민국", currency: Currency(unitTitle: "원", unit: 1.0))
      return .local(korea)
    case "과거의 나":
      return .previous
    default:
      return .empty
    }
  }
  
  private var userBirdTypeName: String? {
    return findMostFrequentBird(for: userRecords)
  }
  
  private func findMostFrequentBird(for records: [UserRecord]) -> String? {
    var frequency: [String: Int] = [:]
    var mostFrequentKey: String?
    var maxCount = 0
    
    for record in records {
      let targetJudgmentType = record.userJudgment
      
      for (key, judgment) in record.externalJudgment where judgment == targetJudgmentType {
        // Update frequency count
        let count = (frequency[key] ?? 0) + 1
        frequency[key] = count
        
        // Update most frequent key on-the-fly
        if count > maxCount {
          maxCount = count
          mostFrequentKey = key
        }
      }
    }
    
    return mostFrequentKey
  }
}

extension UserJudgmentTypeModel {
  var title: String {
    switch self.userBirdType {
    case .foreign(let country):
      return "\(country.name)에 왔으면,\n현지 물가를 따라야지!"
    case .local:
      return "해외 여행을 가서도\n한국 물가를 따라야지!"
    case .previous:
      return "내가 판단했던 기록을\n언제나 참고하지!"
    case .empty:
      return "판단한 금액이\n아직 없어요!"
    }
  }
  
  var boldTitle: String {
    switch self.userBirdType {
    case .foreign:
      return "현지 물가"
    case .local:
      return "한국 물가"
    case .previous:
      return "내가 판단했던 기록"
    case .empty:
      return "아직 없어요!"
    }
  }
}

extension UserJudgmentTypeModel {
  var descriptionTitle: String {
    switch self.userBirdType {
    case .empty:
      return "지출 판단을 시작하세요"
    default:
      if let userBirdTypeName {
        return "\(userBirdTypeName) 짹짹이 손을 많이 들어주었어요"
      } else {
        return "짹짹이 손을 들어주어요"
      }
    }
  }
  
  var descriptionContents: String {
    switch self.userBirdType {
    case .foreign(let country):
      switch country.name {
      case "스위스":
        return """
          스위스 물가를 기준으로 구매 여부를 
          결정하는 스위스 10년차 짹짹이와 
          비슷한 판단 기준을 가지고 있어요.
          끝없이 펼쳐지는 대자연을 좋아하게 될거에요.
          """
      case "베트남":
        return """
          베트남 물가를 기준으로 구매 여부를 
          결정하는 베트남 10년차 짹짹이와 
          비슷한 판단 기준을 가지고 있어요.
          베트남 쌀국수의 맛을 잊지 못할 거에요.
          """
      default:
        return """
          해외살이 10년차 짹짹이와 
          비슷한 판단 기준을 가지고 있어요.
          끝없이 펼쳐지는 대자연을 좋아하게 될거에요.
          """
      }
    case .local:
      return """
        한국 물가를 기준으로 구매 여부를 
        결정하는 한국 토박이 짹짹이와 
        비슷한 판단 기준을 가지고 있어요.
        여행갈 때 컵라면을 챙기는 편이에요.
        """
    case .previous:
      return """
        이전 구매 결정을 기준으로 현재의 구매를 
        결정하는 과거의 나 짹짹이와 
        비슷한 판단 기준을 가지고 있어요.
        균형 있는 소비를 하려고 노력하기도 해요.
        """
    case .empty:
      return """
        구매 결정을 기록하면 판단한 기준으로 
        당신의 판단 유형이 나타납니다.
        구매 결정을 기록하고, 나는 어떤 짹짹이의
        손을 가장 많이 들었는지 알아볼까요?
        """
    }
  }
}

/// 새들의 말풍선 속 말
extension UserJudgmentTypeModel {
  func getBirdChat(at location: UserInfoBirdChatLocation) -> String {
    switch self.userBirdType {
    case .foreign(let country):
      return getForeignBirdChat(at: location, countryName: country.name)
    case .local:
      switch location {
      case .left: return "컵라면 챙겨"
      case .rightTop: return "아껴 쓰자"
      case .rightBottom: return "🇰🇷"
      }
    case .previous:
      switch location {
      case .left: return "균형있는 소비"
      case .rightTop: return "얼마 썼더라?"
      case .rightBottom: return "😎"
      }
    case .empty:
      switch location {
      case .left: return "빨리 기록해"
      case .rightTop: return "궁금하지?"
      case .rightBottom: return "😎"
      }
    }
  }
  
  private func getForeignBirdChat(at location: UserInfoBirdChatLocation, countryName: String) -> String {
    switch countryName {
    case "베트남":
      switch location {
      case .left: return "쌀국수 좋아"
      case .rightTop: return "몽땅 쓰자"
      case .rightBottom: return "🇻🇳"
      }
    case "스위스":
      switch location {
      case .left: return "자연과 낭만"
      case .rightTop: return "휴식 좋아"
      case .rightBottom: return "🇨🇭"
      }
    default:
      switch location {
      case .left: return "구매는 신중하게"
      case .rightTop: return "여행 좋아"
      case .rightBottom: return "🌏"
      }
    }
  }
}
