//
//  TravelSearchBar.swift
//  AKCOO
//
//  Created by KIM SEOWOO on 11/10/24.
//

import UIKit

class  TravelSearchBar: UIView {
  
  
  // MARK: - Views
  private let searchBar = UISearchBar().set {
    $0.placeholder = "국가를 검색하세요"
  }

  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  // MARK: - Setup Methods

  private func setupView() {

  }
  
  private func setupConstraints() {
   
  }
}