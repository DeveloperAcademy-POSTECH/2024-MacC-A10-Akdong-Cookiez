//
//  TravelSearchBarView.swift
//  AKCOO
//
//  Created by 티나 on 11/10/24.
//

import UIKit

class  TravelSearchBarView: UIView {
  
  // MARK: - Views
  private let searchBar = UISearchBar().set {
    $0.placeholder = "국가를 검색하세요"
    $0.setImage(UIImage(named: "searchBarGlass"), for: UISearchBar.Icon.search, state: .normal)
  }

  // MARK: - Initializers
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
    addSubview(searchBar)
    
    if let textfield = searchBar.value(forKey: "searchField") as?
        UITextField {
      // 서치바 배경 색상
      textfield.backgroundColor = UIColor.akColor(.gray1)
      
      // 플레이스홀더 글자 색상
      textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.akColor(.gray3)])
      
      // 서치바 텍스트 입력시 색 정하기
      textfield.textColor = UIColor.akColor(.black)
      
      // 이미지 넣기
      if let rightView = textfield.rightView as? UIImageView {
        rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
      }
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
      searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
    ])
  }
}

#Preview {
  let preview = TravelSearchBarView()
  return preview
}
