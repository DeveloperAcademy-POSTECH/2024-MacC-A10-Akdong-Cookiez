import UIKit

class BirdReactionCollectionView: UIView {
  // MARK: - Views
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.minimumLineSpacing = 30
    layout.sectionInset = UIEdgeInsets(top: 13, left: 0, bottom: 60, right: 0)
    
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
  private var cellHeights: [IndexPath: CGFloat] = [:]
  
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
  func configure(with birdModels: [BirdModel]) {
    self.birdModels = birdModels
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
      case is ForignBird: return .foriegn
      case is LocalBird: return .local
      case is PreviousDayBird: return .previous
      default: fatalError("Unknown BirdModel type")
      }
    }()
    
    cell.configure(
      name: birdModel.name,
      opinion: birdModel.opinion,
      detail: birdModel.detail,
      buying: birdModel.judgment,
      birdImageType: birdImageType
    )
    
    let calculatedHeight = cell.cellHeight()
    cellHeights[indexPath] = calculatedHeight
    collectionView.alpha = 1
    // 초기 상태 설정 (셀을 화면 위로 이동)
    cell.transform = CGAffineTransform(translationX: birdModel.judgment ? collectionView.frame.width*2 : -collectionView.frame.width*2, y: 0)
    
    UIView.animate(
      withDuration: 0.4, // 좀 더 오래 지속되는 애니메이션
      delay: 0.3 * Double(indexPath.item), // 각 셀이 약간의 시간 차이를 두고 등장
      usingSpringWithDamping: 0.9, // 스프링 효과를 줄 때 사용 (0에 가까울수록 더 강한 스프링)
      initialSpringVelocity: 0.2, // 초기 스프링 속도
      options: [.curveEaseInOut],
      animations: {
        cell.transform = .identity // 원래 위치로 이동
      },
      completion: nil
    )
    
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
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BirdReactionCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    if let height = cellHeights[indexPath] {
      return CGSize(width: collectionView.bounds.width, height: height)
    } else {
      // 셀을 직접 생성하여 높이 계산
      if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdReactionCell.identifier, for: indexPath) as? BirdReactionCell {
        let calculatedHeight = cell.cellHeight()
        cellHeights[indexPath] = calculatedHeight
        return CGSize(width: collectionView.bounds.width, height: calculatedHeight)
      }
      // 기본 높이 값 반환
      return CGSize(width: collectionView.bounds.width, height: 100)
    }
  }
}

#Preview {
  let preview = BirdReactionCollectionView()
  preview.configure(
    with: [
      LocalBird(
        country: .init(
          name: "대한민국",
          currency: .init(
            unitTitle: "원",
            unit: 1
          )
        ),
        judgment: .init(
          userAmount: 30000, standards: [ ]
        )
      )
    ]
  )
  
  return preview
}