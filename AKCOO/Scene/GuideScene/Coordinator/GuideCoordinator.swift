//
//  GuideCoordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 12/1/24.
//

import UIKit

protocol GuideCoordinator: Coordinator {
  func startJudgmentReady(presenting: UIViewController, selectedCountryDetail: CountryDetail)
  func startUserInfo()
}
