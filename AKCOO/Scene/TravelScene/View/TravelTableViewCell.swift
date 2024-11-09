//
//  TravelCellTableViewCell.swift
//  AKCOO
//
//  Created by 박혜운 on 11/4/24.
//

import UIKit

typealias TravelCellInfo = (title: String, durationInfoTitle: String)

class TravelTableViewCell: UITableViewCell {
    static let identifier = "TravelTableViewCell"
    
    // MARK: - Views
    
    private let stackView = UIStackView().set {
    $0.spacing = 0
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .fill
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
    
    private func setupView() {
        
        stackView.addArrangedSubview(travelProcessCircle)
        stackView.addArrangedSubview(countryFlagLabel)
        stackView.addArrangedSubview(countryNameLabel)
      
  
    contentView.addSubview(travelDateLabel)
    contentView.addSubview(stackView)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            
            

            travelProcessCircle.heightAnchor.constraint(equalToConstant: 50),
            travelProcessCircle.widthAnchor.constraint(equalToConstant: 50), 
            
      
            
            // 여행기간 레이블
            travelDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 82),
            travelDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
         

        
        ])
        
    }
}

// MARK: - Public Methods
extension TravelTableViewCell {
    public func setConfigure(info: TravelCellInfo) {
    countryNameLabel.text = info.title
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
