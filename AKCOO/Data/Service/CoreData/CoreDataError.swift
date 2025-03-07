//
//  CoreDataError.swift
//  AKCOO
//
//  Created by Anjin on 11/22/24.
//

import Foundation

enum CoreDataError: LocalizedError {
  case getFailed
  case deleteFailed
  case mapFromEntityFailed
  
  var errorDescription: String? {
    switch self {
    case .getFailed:
      return "CoreData에서 가져오기를 실패했습니다."
    case .deleteFailed:
      return "CoreData에서 삭제를 실패했습니다."
    case .mapFromEntityFailed:
      return "CoreData Entity에서 Domain Entity로 매핑을 실패했습니다."
    }
  }
}
