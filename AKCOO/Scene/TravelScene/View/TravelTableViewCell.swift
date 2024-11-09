//
//  TravelCellTableViewCell.swift
//  AKCOO
//
//  Created by 박혜운 on 11/4/24.
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
    $0.backgroundColor = UIColor.akColor(.akBlue)
    }
    
    private let countryNameLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium24)
    $0.textColor = UIColor.akColor(.black)
    $0.text = "국가명"
    $0.backgroundColor = UIColor.akColor(.akYellow)

    }
    
    private let travelProcessCircle = UIView().set {
    $0.backgroundColor = UIColor.akColor(.akGreen)
    }
  
    
    private let travelDateLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = UIColor.akColor(.black)
    $0.backgroundColor = UIColor.akColor(.akYellow)
    $0.text = "여행날짜"
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
        travelProcessCircle.layer.cornerRadius = travelProcessCircle.frame.width / 2
        
        // cell 간격 주기
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
    }
    
    private func setupView() {
        contentView.addSubview(stackView)
        contentView.addSubview(travelDateLabel)
     
//        listContainerView.addSubview(stackView)
        stackView.addArrangedSubview(travelProcessCircle)
        stackView.addArrangedSubview(titleView)
        
        titleView.addSubview(countryFlagLabel)
        titleView.addSubview(countryNameLabel)
        
        // Set content hugging for titleView
            titleView.setContentHuggingPriority(.required, for: .horizontal)
            countryFlagLabel.setContentHuggingPriority(.required, for: .horizontal)
            countryNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        

    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),  
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            
            travelProcessCircle.heightAnchor.constraint(equalToConstant: 50),
            travelProcessCircle.widthAnchor.constraint(equalToConstant: 50), 
            
            titleView.heightAnchor.constraint(equalToConstant: 50),
        
            countryFlagLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 13),
            countryFlagLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 10),
            
            countryNameLabel.leadingAnchor.constraint(equalTo: countryFlagLabel.trailingAnchor, constant: 0),
            countryNameLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 13),
         
      
            // 여행기간 레이블
            travelDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 82),
            travelDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
         

        
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
@available(iOS 17.0, *)
#Preview {
    let vc = TravelTableViewCell()
    return vc
}
