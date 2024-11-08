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
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

// MARK: - Public Methods
extension TravelTableViewCell {
  public func setConfigure(info: TravelCellInfo) {
    let (mainTitle, dateTitle) = info
    titleLabel.text = mainTitle
    dateLabel.text = dateTitle
  }
}
