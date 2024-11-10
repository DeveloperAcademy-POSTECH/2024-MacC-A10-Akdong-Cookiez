//
//  ViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/4/24.
//

import UIKit

class TravelListSceneController: UIViewController {
  weak var coordinator: TravelListCoordinator?
  private let travelUseCase: TravelUseCase
  
  // MARK: - Properties
  private var travels = [Travel]()
  
  // MARK: - Views
    let titleLabel = UILabel().set {
      $0.font = .akFont(.gmarketMedium30)
      $0.textColor = .akColor(.black)
      $0.text = "여행리스트"
  }
  
  let travelTableView: TravelTableView = TravelTableView().set()
  
  // MARK: - Initializers
  init(useCase: TravelUseCase) {
    self.travelUseCase = useCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupConstraints()
    initConfigure()
    
    // cell 동적높이
    travelTableView.estimatedRowHeight = 118
    travelTableView.rowHeight = UITableView.automaticDimension
    travelTableView.backgroundColor = .cyan
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  // MARK: - Setup Methods
  private func setupView() {
    view.addSubview(titleLabel)
    view.addSubview(travelTableView)
    setupNavigationBar()

    travelTableView.travelDelegate = self
  }
  
  private func setupNavigationBar() {
    let addButton = UIBarButtonItem(
      image: UIImage(systemName: "plus"),
      style: .plain,
      target: self,
      action: #selector(didTapAddButton)
    )
    navigationItem.rightBarButtonItem = addButton
  }
  
  private func setupConstraints() {
    
    NSLayoutConstraint.activate([
      
      // 테이블뷰
      travelTableView.topAnchor.constraint(equalTo:  titleLabel.bottomAnchor, constant: 20),
      travelTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .AK.commonHorizontal),
      travelTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.AK.commonHorizontal),
      travelTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      // 타이틀레이블
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .AK.commonHorizontal + 5)
    ])
  }
  
  // MARK: - Private Methods
  private func initConfigure() {
    // useCase에서 데이터 가져와서 초기 세팅
      self.travels.append(.init( flag: "🇹🇭", country: "태국", currency: .init(unitTitle: "바트", unit: 4), startDate: .now, endDate: .now.addingTimeInterval(3), budget: .init(total: 3000000)))
      let info: [TravelCellInfo] = travels.map { ($0.flag, $0.country, "어쩌구기간") }
    travelTableView.setConfigure(info: info)
  }
  
  // MARK: - Actions
  @objc private func didTapAddButton() {
    coordinator?.tappedPlusButton()
  }
}

// MARK: - Public Methods
extension TravelListSceneController {
  
  public func submitNewTravel(_ travel: Travel) {
    print("VC가 추가 된 사실 받음")
  }
}

// MARK: - DataSource
extension TravelListSceneController: TravelTableViewDelegate {
  func selectedCell(at indexPath: IndexPath) {
    let travel = travels[indexPath.row]
    coordinator?.tappedCell(id: travel.id)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.travels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as? TravelTableViewCell else {
      return UITableViewCell()
    }

    // "어쩌구기간"은 travels [indexPath.row]의 starDate와 dueDate를 통해 도출되는 String
    let travelInfo = (travels[indexPath.row].flag, travels[indexPath.row].country, "어쩌구기간")
    cell.setConfigure(info: travelInfo)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
   }
}

// Preview 화면
#Preview {
  let vc = TravelListSceneController(useCase: TravelUseCase())
  return vc
}
