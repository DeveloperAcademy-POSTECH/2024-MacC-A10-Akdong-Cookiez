//
//  TravelListCoordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 11/6/24.
//

import Foundation

protocol TravelListCoordinator: Coordinator {
  func tappedPlusButton()
  func tappedCell(id countryId: String)
}

protocol TravelListCoordinatorFinishDelegate: CoordinatorFinishDelegate {
  func tappedCell(countryId: String)
}

// 하위 코디네이터가 상위에게 데이터 전달해 줘야하는 상황에서 처리 방법 고민중이었음 
