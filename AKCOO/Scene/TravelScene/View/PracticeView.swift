//
//  PracticeView.swift
//  AKCOO
//
//  Created by KIM SEOWOO on 11/9/24.
//

//
//  TravelCellTableViewCell.swift
//  AKCOO
//
//  Created by 박혜운 on 11/4/24.
//

import UIKit


class PracticeView: UIViewController {
   
    
    // MARK: - Views
    private let listContainerView = UIView().set {
    $0.backgroundColor = UIColor.akColor(.gray1)
    $0.backgroundColor = .black
    }
    
    private let travelProcessCircle = UIView().set {
    $0.backgroundColor = UIColor.akColor(.akGreen)
    }
    
    private let travelTitleView = UIView().set {
    $0.backgroundColor = .akColor(.white)
    $0.layer.borderWidth = 0.25
    $0.layer.borderColor = UIColor.akColor(.black).cgColor
    }
    
    private let countryFlagLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium24)
    $0.text = "🇹🇭"
    }
    
    private let countryNameLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium24)
    $0.textColor = UIColor.akColor(.black)
    $0.text = "국가명"
    }
    
    private let travelDateLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = UIColor.akColor(.black)
    $0.text = "여행날짜"
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
      super.viewDidLoad()
        setupView()
        setupConstrains()
    }
    
  
    private func setupView() {
        
        view.addSubview(listContainerView)
        
        listContainerView.addSubview(travelTitleView)
        travelTitleView.addSubview(countryFlagLabel)
        travelTitleView.addSubview(countryNameLabel)
        
        listContainerView.addSubview(travelDateLabel)
        listContainerView.addSubview(travelProcessCircle)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            
            // 컨테이너뷰
            listContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // travelProcessCircle
            travelProcessCircle.topAnchor.constraint(equalTo: listContainerView.topAnchor, constant: 22),
            travelProcessCircle.leadingAnchor.constraint(equalTo: listContainerView.leadingAnchor, constant: 20),
            
            // 타이틀뷰 레이블
            travelTitleView.topAnchor.constraint(equalTo: listContainerView.topAnchor, constant: 22),
            travelTitleView.leadingAnchor.constraint(equalTo: listContainerView.leadingAnchor, constant: 70),
            
            // 국기 레이블
            countryFlagLabel.leadingAnchor.constraint(equalTo: travelTitleView.leadingAnchor, constant: 10),
            countryFlagLabel.topAnchor.constraint(equalTo: travelTitleView.topAnchor, constant: 13),
            
            // 국가명 레이블
            countryNameLabel.trailingAnchor.constraint(equalTo: travelTitleView.trailingAnchor, constant: 10),
            countryNameLabel.topAnchor.constraint(equalTo: travelTitleView.topAnchor, constant: 13),
            
            // 여행기간 레이블
            travelDateLabel.bottomAnchor.constraint(equalTo: listContainerView.bottomAnchor, constant: 22),
            travelDateLabel.leadingAnchor.constraint(equalTo: listContainerView.leadingAnchor, constant: 30)
        ])
        
    }
}


// Preview 화면
@available(iOS 17.0, *)
#Preview {
    let vc = PracticeView()
    return vc
}

