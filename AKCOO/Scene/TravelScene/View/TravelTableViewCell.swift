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
//  @IBOutlet private weak var titleLabel: UILabel!
//  @IBOutlet private weak var dateLabel: UILabel!
    
    private let travelProcessCircle = UIView().set {
    $0.layer.backgroundColor = UIColor.akColor(.akGreen).cgColor
    $0.layer.cornerRadius = $0.frame.width / 2
    $0.clipsToBounds = true
    }
    
    private let countryFlagLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium24)
    }
    
    private let countryNameLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium24)
    $0.textColor = UIColor.akColor(.black)
    }
    
    // travelProcessCircle, countryFlagLabel, countryName을 담을 스택뷰
    private let stackContainerView = UIStackView().set {
    $0.axis = .horizontal
    $0.distribution = .fill
    $0.alignment = .fill
    }
    
    private let travelDateLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium14)
    $0.textColor = UIColor.akColor(.black)
    }
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
      setupView()
      setupConstrains()
  }
    
    private func setupView() {
    stackContainerView.addArrangedSubview(travelProcessCircle)
    stackContainerView.addArrangedSubview(countryFlagLabel)
    stackContainerView.addArrangedSubview(countryNameLabel)
    contentView.addSubview(travelDateLabel)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            travelProcessCircle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            travelProcessCircle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryFlagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            countryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            travelDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 22),
            travelDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30)
        ])
    }
}

// MARK: - Public Methods
extension TravelTableViewCell {
    public func setConfigure(info: TravelCellInfo) {
//        
//    let (mainTitle, dateTitle) = info
//    titleLabel.text = mainTitle
//    dateLabel.text = dateTitle
        countryFlagLabel.text = info.title
        countryNameLabel.text = info.title
        travelDateLabel.text = info.durationInfoTitle
        
    }
}

// Preview 화면
@available(iOS 17.0, *)
#Preview {
  let vc = TravelTableViewCell()
  return vc
}
