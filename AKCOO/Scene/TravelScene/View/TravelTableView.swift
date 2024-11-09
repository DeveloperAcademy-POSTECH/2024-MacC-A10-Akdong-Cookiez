//
//  TravelTableView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/4/24.
//

import UIKit

protocol TravelTableViewDelegate: AnyObject {
  func selectedCell(at indexPath: IndexPath)
}

class TravelTableView: UITableView {
  weak var travelDelegate: TravelTableViewDelegate?
  
  // MARK: - Properties
  private var travelInfos: [TravelCellInfo] = [] {
    didSet { reloadData() }
  }
  
  // MARK: - Initializers
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setupView()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
    setupConstraints()
  }
  
  // MARK: - Setup Methods
  private func setupView() {
//    let travelCell = UINib(nibName: TravelTableViewCell.identifier, bundle: nil)
//    register(travelCell, forCellReuseIdentifier: TravelTableViewCell.identifier)
//
   // 셀의 등록과정⭐️⭐️⭐️ 
   register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.identifier)

    self.backgroundColor = .clear
    self.dataSource = self
    self.delegate = self
  }
  
  private func setupConstraints() {}
}

// MARK: - Public Methods
extension TravelTableView {
  public func setConfigure(info travelInfos: [TravelCellInfo]) {
    self.travelInfos = travelInfos
  }
}

// MARK: - DataSource
extension TravelTableView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return travelInfos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else {
      return UITableViewCell()
    }
    
    let travelInfo = travelInfos[indexPath.row]
    cell.setConfigure(info: travelInfo)
    
    return cell
  }
}

// MARK: - Delegate (Output)
extension TravelTableView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    travelDelegate?.selectedCell(at: indexPath)
  }
}

// Preview 화면
@available(iOS 17.0, *)
#Preview {
  let vc = TravelTableView()
  return vc
}
