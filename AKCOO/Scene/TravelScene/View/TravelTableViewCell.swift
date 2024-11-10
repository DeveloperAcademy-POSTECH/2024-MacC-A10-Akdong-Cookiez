//
//  TravelCellTableViewCell.swift
//  AKCOO
//
//  Created by 티나 on 11/10/24.
//

import UIKit

typealias TravelCellInfo = (flagTitle: String, countryTitle: String, durationInfoTitle: String)

class TravelTableViewCell: UITableViewCell {
  static let identifier = "TravelTableViewCell"
    
    // MARK: - Views
    private let stackView = UIStackView().set {
      $0.spacing = 0
      $0.axis = .horizontal
      $0.distribution = .fill
      $0.alignment = .fill
    }
    
    private let titleView = UIView().set {
      $0.backgroundColor = UIColor.akColor(.white)
      $0.layer.borderWidth = 0.3
      $0.layer.cornerRadius = 25
      $0.layer.borderColor = UIColor.akColor(.black).cgColor
    }
    
    private let countryFlagLabel = UILabel().set {
      $0.font = .akFont(.gmarketMedium24)
      $0.text = "국기"
      $0.adjustsFontForContentSizeCategory = true

    }
    
    private let countryNameLabel = UILabel().set {
      $0.font = .akFont(.gmarketMedium24)
      $0.textColor = UIColor.akColor(.black)
      $0.text = "국가명국가명"
      $0.adjustsFontForContentSizeCategory = true
    }
    
    private let travelProcessCircle = UIView().set {
      $0.backgroundColor = UIColor.akColor(.akGreen)
      $0.layer.masksToBounds = true
    }
    
    private let arrowImage = UIImageView().set {
      $0.contentMode = .scaleAspectFill
      $0.image = UIImage(named: "arrowRight")
    }
  
    private let travelDateLabel = UILabel().set {
      $0.font = .akFont(.gmarketMedium14)
      $0.textColor = UIColor.akColor(.black)
      $0.text = "여행날짜"
      $0.adjustsFontForContentSizeCategory = true
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupView()
      setupConstrains()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    // Nib 파일로부터 객체가 초기화된 후 호출되는 메서드
    override func awakeFromNib() {
      super.awakeFromNib()
    }
   
    override func layoutSubviews() {
      super.layoutSubviews()
        
    // view를 원으로 만들기
    travelProcessCircle.layer.cornerRadius = travelProcessCircle.frame.height / 2
    }
    
    private func setupView() {
      contentView.backgroundColor = UIColor.akColor(.gray1)
      contentView.layer.cornerRadius = 25
      contentView.layer.masksToBounds = true
      
      contentView.addSubview(stackView)
      contentView.addSubview(travelDateLabel)
        
      stackView.addArrangedSubview(travelProcessCircle)
      stackView.addArrangedSubview(titleView)
        
      titleView.addSubview(countryFlagLabel)
      titleView.addSubview(countryNameLabel)
        
      travelProcessCircle.addSubview(arrowImage)
      
      // 콘텐츠 허깅 우선순위 설정
      countryFlagLabel.setContentHuggingPriority(.required, for: .horizontal)
      countryFlagLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
      countryNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
      countryNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    private func setupConstrains() {
      NSLayoutConstraint.activate([
        
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            
      // 동그라미
      travelProcessCircle.heightAnchor.constraint(equalTo: stackView.heightAnchor),
      travelProcessCircle.widthAnchor.constraint(equalTo: travelProcessCircle.heightAnchor),
      
      // 화살표 이미지
      arrowImage.centerYAnchor.constraint(equalTo: travelProcessCircle.centerYAnchor),
      arrowImage.centerXAnchor.constraint(equalTo: travelProcessCircle.centerXAnchor),
          
      // 타이틀뷰 (국기+국가명)
      titleView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
      titleView.leadingAnchor.constraint(equalTo: countryFlagLabel.leadingAnchor, constant: -10),
      titleView.trailingAnchor.constraint(equalTo: countryNameLabel.trailingAnchor, constant: 10),
     
        
      // 국기
      countryFlagLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 10),
      countryFlagLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -10),
      countryFlagLabel.trailingAnchor.constraint(equalTo: countryNameLabel.leadingAnchor, constant: 0),
           
      // 국가명
      countryNameLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 10),
      countryNameLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -10),
      
      // 여행날짜
      travelDateLabel.topAnchor.constraint(equalTo:  stackView.bottomAnchor, constant: 10),
      travelDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22),
      travelDateLabel.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 30),
      travelDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
        
    }
}

// MARK: - Public Methods
extension TravelTableViewCell {
    public func setConfigure(info: TravelCellInfo) {
    countryFlagLabel.text = info.flagTitle
    countryNameLabel.text = info.countryTitle
    travelDateLabel.text = info.durationInfoTitle
    }
}

// MARK: - UIView Extension for 'set' Method
extension UIView {
  func set(_ configure: (UIView) -> Void) -> UIView {
    configure(self)
    return self
  }
}

// Preview 화면
#Preview {
let vc = TravelTableViewCell()
return vc
}
