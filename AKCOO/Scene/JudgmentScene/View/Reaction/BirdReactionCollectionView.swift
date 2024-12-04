//
//  BirdReactionCollectionView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/18/24.
//

import UIKit

class BirdReactionCollectionView: UIView {
  // MARK: - Views
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.minimumLineSpacing = 30
    layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 80, right: 0)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(BirdReactionCell.self, forCellWithReuseIdentifier: BirdReactionCell.identifier)
    collectionView.alpha = 0
    return collectionView
  }()
  
  // MARK: - Properties
  private var birdModels: [BirdModel] = []
  private var userAmount: Double = 0
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
  
  // MARK: - Setup Methods
  private func setupViews() {
    addSubview(collectionView)
    collectionView.backgroundColor = .clear
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  // MARK: - Public Methods
  func configure(
    with birdModels: [BirdModel],
    userAmount: Double
  ) {
    self.birdModels = birdModels
    self.userAmount = userAmount
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDataSource
extension BirdReactionCollectionView: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return birdModels.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdReactionCell.identifier, for: indexPath) as? BirdReactionCell else {
      return UICollectionViewCell()
    }
    
    let birdModel = birdModels[indexPath.item]
    let birdImageType: BirdCharacterImageType = {
      switch birdModel {
      case is ForeignBird: return .foriegn
      case is LocalBird: return .local
      case is PreviousBird: return .previous
      default: fatalError("Unknown BirdModel type")
      }
    }()
    
    cell.configure(
      bird: birdModel,
      userAmount: userAmount,
      birdImageType: birdImageType
    )
    
    collectionView.alpha = 1
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension BirdReactionCollectionView: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let selectedCell = collectionView.cellForItem(at: indexPath) as? BirdReactionCell
    else { return }
    selectedCell.tappedCell()
    collectionView.performBatchUpdates(nil, completion: nil)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? BirdReactionCell else { return }
    
    cell.transform = CGAffineTransform(translationX: birdModels[indexPath.item].judgment ? collectionView.frame.width * 2 : -collectionView.frame.width * 2, y: 0)
    
    UIView.animate(
      withDuration: 0.4,
      delay: 0.3 * Double(indexPath.item),
      usingSpringWithDamping: 0.9,
      initialSpringVelocity: 0.2,
      options: [.curveEaseInOut],
      animations: {
        cell.transform = .identity
      },
      completion: nil
    )
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BirdReactionCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    // 가로 길이만 컬렉션뷰 크기로 설정
    let width = collectionView.bounds.width - 12*2
    let height: CGFloat = 100 // 기본 높이 값
    return CGSize(width: width, height: height)
  }
}

#Preview {
  let preview = BirdReactionCollectionView()
  preview.configure(
    with: [
      LocalBird(
        birdCountry: .init(
          name: "한국",
          currency: Currency(
            unitTitle: "원",
            unit: 1
          )
        ),
        judgment: .init(
          userQuestion: .init(
            country: .init(
              name: "베트남",
              currency: .init(
                unitTitle: "동",
                unit: 0.055
              )
            ),
            category: "숙소",
            amount: 300000
          ),
          standards: [ ]
        )
      )
    ],
    userAmount: 30000
  )
  
  return preview
}
